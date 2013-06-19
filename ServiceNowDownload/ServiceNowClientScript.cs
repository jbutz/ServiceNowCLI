using System.Runtime.Serialization;

namespace ServiceNow
{
    [DataContract]
    class ClientScript : ServiceNow.Script
    {

        [DataMember(Name = "active")]
        public bool active { get; set; }

        [DataMember(Name = "applies_extended")]
        public bool applies_extended { get; set; }

        [DataMember(Name = "condition")]
        public string condition { get; set; }

        [DataMember(Name = "description")]
        public string description { get; set; }

        [DataMember(Name = "field")]
        public string field { get; set; }

        [DataMember(Name = "global")]
        public bool global { get; set; }

        [DataMember(Name = "messages")]
        public string messages { get; set; }

        [DataMember(Name = "name")]
        public string name { get; set; }

        [DataMember(Name = "script")]
        public string script { get; set; }

        [DataMember(Name = "sys_class_name")]
        public string sys_class_name { get; set; }

        [DataMember(Name = "sys_created_by")]
        public string sys_created_by { get; set; }

        [DataMember(Name = "sys_created_on")]
        public string sys_created_on { get; set; }

        [DataMember(Name = "sys_domain")]
        public string sys_domain { get; set; }

        [DataMember(Name = "sys_id")]
        public string sys_id { get; set; }

        [DataMember(Name = "sys_mod_count")]
        public int sys_mod_count { get; set; }

        [DataMember(Name = "sys_overrides")]
        public string sys_overrides { get; set; }

        [DataMember(Name = "sys_updated_by")]
        public string sys_updated_by { get; set; }

        [DataMember(Name = "sys_updated_on")]
        public string sys_updated_on { get; set; }

        [DataMember(Name = "table")]
        public string table { get; set; }

        [DataMember(Name = "type")]
        public string type { get; set; }

        [DataMember(Name = "view")]
        public string view { get; set; }

        /*!
         * Implementing Interface Functions
         */
        public override void getScripts(string table)
        {
            doDownload<ServiceNow.ClientScript>("sys_script_client", table, "table", ".cs.js");
        }
        protected override string getName()
        {
            return name;
        }
        protected override string getScript()
        {
            return script;
        }
    }
}
