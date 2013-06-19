using System;
using System.Configuration;
using System.IO;
using System.Net;
using System.Runtime.Serialization;
using System.Runtime.Serialization.Json;

namespace ServiceNow
{
    [DataContractAttribute]
    abstract class Script
    {
        protected static string baseURL = ConfigurationManager.ConnectionStrings["snInstance"].ConnectionString;
        private static string _username;
        private static string _password;
        private static string _directory;
        public abstract void getScripts(string table);
        protected abstract string getName();
        protected abstract string getScript();

        public void Initialize(string username, string password, string directory)
        {
            _username = username;
            _password = password;
            _directory = directory;
        }

        /*!
         * HTTP Request Stuff
         */
        protected void doDownload<T>(string scriptTypeName, string scriptTable, string tableColumn, string ext)
        {
            var url = baseURL + scriptTypeName + ".do?JSON&sysparm_action=getRecords&sysparm_query="+tableColumn+"=" + scriptTable + "&displayvariables=true";
            var ms = getURL(url);
            if (ms == null) return;
            try
            {
                DataContractJsonSerializer json = new DataContractJsonSerializer(typeof(ServiceNow.Response<T>));
                ServiceNow.Response<T> response = (ServiceNow.Response<T>)json.ReadObject(ms);
                Script[] scripts = response.records as Script[];
                foreach (Script s in scripts)
                {
                    if (sanitizeFilename(s.getName()).Trim() != "")
                    {
                        var fullName = _directory + System.IO.Path.DirectorySeparatorChar + sanitizeFilename(s.getName()).Trim() + ext;

                        System.IO.File.WriteAllText(fullName, s.getScript());

                        Console.WriteLine(sanitizeFilename(s.getName()).Trim() + ext + " saved");
                    }
                }
            }
            catch (Exception e)
            {
                Console.Error.WriteLine(e);
            }
        }
        private static MemoryStream getURL(string url)
        {
            var content = new MemoryStream();
            var webReq = (HttpWebRequest)WebRequest.Create(url);

            webReq.Credentials = GetCredential(url);
            webReq.PreAuthenticate = true;
            // Send the request to the Internet resource and wait for 
            // the response. 
            // Note: you can't use HttpWebRequest.GetResponse in a Windows Store app.
            try
            {
                using (WebResponse response = webReq.GetResponse())
                {
                    using (Stream responseStream = response.GetResponseStream())
                    {
                        // Read the bytes in responseStream and copy them to content.  
                        responseStream.CopyTo(content);
                    }
                }
            }
            catch (System.Net.WebException e)
            {
                Console.Error.WriteLine(e.Message);
                return null;
            }

            content.Position = 0;
            return content;

        }
        private static CredentialCache GetCredential(string url)
        {
            ServicePointManager.SecurityProtocol = SecurityProtocolType.Ssl3;
            if (Type.GetType("Mono.Runtime") != null) // Running Mono?
            { // The next line is obsolete, but mono needs it.
                ServicePointManager.CertificatePolicy = new ServiceNowDownload.HTTPSecurity();
            }

            CredentialCache credentialCache = new CredentialCache();
            credentialCache.Add(new System.Uri(url), "Basic", new NetworkCredential(_username, _password));
            return credentialCache;
        }

        /*!
         * Cleanup functions
         */
        private static string sanitizeFilename(string name)
        {
            string invalidChars = System.Text.RegularExpressions.Regex.Escape(new string(System.IO.Path.GetInvalidFileNameChars()));
            string invalidReStr = string.Format(@"([{0}]*\.+$)|([{0}]+)", invalidChars);
            return System.Text.RegularExpressions.Regex.Replace(name, invalidReStr, "_");
        }
    }
}
