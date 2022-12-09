using RestSharp;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace NotifierService
{
    class Program
    {
        static void Main(string[] args)
        {
            string VaccineNotificationUrl = @"https://aya-uwindsor-test-shalinshah777-dev.apps.sandbox.x8i5.p1.openshiftapps.com/NotifierServiceController/VaccineNotification";
            string doctorAppUrl = @"https://aya-uwindsor-test-shalinshah777-dev.apps.sandbox.x8i5.p1.openshiftapps.com/NotifierServiceController/DoctorAppointmentNotification";

            while (true)
            {
                Console.ReadKey();

                CallAPI(VaccineNotificationUrl);
                //Thread.Sleep(60 * 60 * 1000);
                CallAPI(doctorAppUrl);
                //Thread.Sleep(60 * 60 * 1000);
                 Console.ReadKey();
            }
        }

        public static  void CallAPI(string url) {

            string html = string.Empty;
            

            HttpWebRequest request = (HttpWebRequest)WebRequest.Create(url);
            request.AutomaticDecompression = DecompressionMethods.GZip;

            using (HttpWebResponse response = (HttpWebResponse)request.GetResponse())
            using (Stream stream = response.GetResponseStream())
            using (StreamReader reader = new StreamReader(stream))
            {
                html = reader.ReadToEnd();
            }

            Console.WriteLine(html);
           // Console.ReadKey();
        }

      
    }
}
