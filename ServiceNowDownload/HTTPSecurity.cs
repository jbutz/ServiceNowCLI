using System;
using System.Net;
using System.Security.Cryptography.X509Certificates;

namespace ServiceNowDownload
{
    public enum CertificateProblem : long
    {
        CertEXPIRED = 0x800B0101,
        CertVALIDITYPERIODNESTING = 0x800B0102,
        CertROLE = 0x800B0103,
        CertPATHLENCONST = 0x800B0104,
        CertCRITICAL = 0x800B0105,
        CertPURPOSE = 0x800B0106,
        CertISSUERCHAINING = 0x800B0107,
        CertMALFORMED = 0x800B0108,
        CertUNTRUSTEDROOT = 0x800B0109,
        CertCHAINING = 0x800B010A,
        CertREVOKED = 0x800B010C,
        CertUNTRUSTEDTESTROOT = 0x800B010D,
        CertREVOCATION_FAILURE = 0x800B010E,
        CertCN_NO_MATCH = 0x800B010F,
        CertWRONG_USAGE = 0x800B0110,
        CertUNTRUSTEDCA = 0x800B0112
    }

    class HTTPSecurity : ICertificatePolicy
    {
        public bool CheckValidationResult(ServicePoint sp, X509Certificate cert, WebRequest request, int problem)
        {
            // Hostname must end in ".service-now.com"
            return System.Text.RegularExpressions.Regex.Match(sp.Address.Host, @"\.service-now\.com$").Success;

        }

        private String GetProblemMessage(CertificateProblem Problem)
        {
            String ProblemMessage = "";
            CertificateProblem problemList = new CertificateProblem();
            String ProblemCodeName = Enum.GetName(problemList.GetType(), Problem);
            if (ProblemCodeName != null)
                ProblemMessage = ProblemMessage + "-Certificateproblem:" +
                   ProblemCodeName;
            else
                ProblemMessage = "Unknown Certificate Problem";
            return ProblemMessage;
        }
    }
}
