using System.Runtime.Serialization;

namespace ServiceNow
{
    [DataContract]
    class Response<T>
    {
        [DataMember(Name = "records")]
        public T[] records { get; set; }
    }
}
