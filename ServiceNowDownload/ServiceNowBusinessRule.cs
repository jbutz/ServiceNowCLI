using System.Runtime.Serialization;

namespace ServiceNow
{
    [DataContract]
    class BusinessRule : ServiceNow.Script
    {
        [DataMember(Name = "action_delete")]
        public bool action_delete { get; set; }

        [DataMember(Name = "action_insert")]
        public bool action_insert { get; set; }

        [DataMember(Name = "action_label")]
        public string action_label { get; set; }

        [DataMember(Name = "action_name")]
        public string action_name { get; set; }

        [DataMember(Name = "action_query")]
        public bool action_query { get; set; }

        [DataMember(Name = "action_run_at")]
        public string action_run_at { get; set; }

        [DataMember(Name = "action_update")]
        public bool action_update { get; set; }

        [DataMember(Name = "active")]
        public bool active { get; set; }

        [DataMember(Name = "application")]
        public string application { get; set; }

        [DataMember(Name = "client_callable")]
        public bool client_callable { get; set; }

        [DataMember(Name = "collection")]
        public string collection { get; set; } // Table

        [DataMember(Name = "condition")]
        public string condition { get; set; }

        [DataMember(Name = "description")]
        public string description { get; set; }

        [DataMember(Name = "name")]
        public string name { get; set; }

        [DataMember(Name = "onclick")]
        public string onclick { get; set; }

        [DataMember(Name = "order")]
        public int order { get; set; }

        [DataMember(Name = "priority")]
        public int priority { get; set; }

        [DataMember(Name = "read_access_action")]
        public bool read_access_action { get; set; }

        [DataMember(Name = "script")]
        public string script { get; set; }

        [DataMember(Name = "sys_created_by")]
        public string sys_created_by { get; set; }

        [DataMember(Name = "sys_created_on")]
        public string sys_created_on { get; set; }

        [DataMember(Name = "sys_domain")]
        public string sys_domain { get; set; }

        [DataMember(Name = "sys_id")]
        public string sys_id { get; set; }

        [DataMember(Name = "sys_mod_count")]
        public string sys_mod_count { get; set; }

        [DataMember(Name = "sys_overrides")]
        public string sys_overrides { get; set; }

        [DataMember(Name = "sys_updated_by")]
        public string sys_updated_by { get; set; }

        [DataMember(Name = "sys_updated_on")]
        public string sys_updated_on { get; set; }

        [DataMember(Name = "when")]
        public string when { get; set; }

        /*!
         * Implementing Interface Functions
         */
        public override void getScripts(string table)
        {
            doDownload <ServiceNow.BusinessRule>("sys_script", table, "collection", ".br.js");
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
