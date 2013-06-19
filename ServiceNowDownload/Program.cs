using System;
using System.Configuration;

namespace ServiceNowDownload
{
    class Program
    {
        static int Main(string[] args)
        {
            Console.WriteLine();
            var _args = new Arguments(args);

            string username = null;
            string password = null;
            string tableName = null;


            if (args.Length < 3 || _args.Exists("help"))
            {
                showHelp();
                handleExit();
                return 0;
            }
            if (ConfigurationManager.ConnectionStrings["snInstance"].ConnectionString == "https://**INSTANCE**.service-now.com/")
            {
                Console.Error.WriteLine("Please update the xml config file with your Service Now instance URL.\n\n");
                handleExit();
                return -1;
            }
            username = args[0];
            password = args[1];
            tableName = args[2];

            if (username == null || password == null)
            {
                Console.Error.WriteLine("Please enter a username and password.\n\n");
                showHelp();
                handleExit();
                return -1;
            }
            if (tableName == null)
            {
                Console.Error.WriteLine("Please enter a table name.\n\n");
                showHelp();
                handleExit();
                return -1;
            }
            ServiceNow.Script s = null;
            // Business Rules
            if (_args.IsTrue("br") || _args.IsTrue("businessrule"))
            {
                Console.WriteLine("Downloading business rules for " + tableName);
                s = new ServiceNow.BusinessRule();
            }
            else if(_args.IsTrue("cs") || _args.IsTrue("clientscript"))
            {
                Console.WriteLine("Downloading client scripts for " + tableName);
                s = new ServiceNow.ClientScript(); 
            }
            string dir = "";
            try
            {
                dir = System.IO.Directory.GetCurrentDirectory();
                s.Initialize(username, password, dir);
                s.getScripts(tableName);
            }
            catch (Exception e)
            {
                Console.Error.WriteLine(e.Message);
            }

            handleExit();
            return 0;
        }

        public static void handleExit()
        {
            Console.Write("\n\nPress any key to exit...");
            Console.ReadKey();
        }

        public static void showHelp()
        {
            string output = "";
            output += System.AppDomain.CurrentDomain.FriendlyName+" USERNAME PASSWORD TABLE SCRIPT_FLAG\n";
            output += "\n";
            output += "Arguments:\n";
            output += "-u USERNAME				Username used for authentication\n";
            output += "-p PASSWORD				Password used for authentication\n";
            output += "-t TABLE				Table scripts are associated with\n";
            output += "\n";
            output += "Script Flags:\n";
            output += "-br, --businessrule		        Downloads Business Rules\n";
            output += "-cs, --clientscript		        Downloads Client Scripts\n";
            output += "\n";
            output += "General Flags\n";
            output += "--help					Displays this message\n";
            Console.Write(output);
        }

        
    }
}
