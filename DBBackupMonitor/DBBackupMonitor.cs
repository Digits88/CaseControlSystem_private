using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.ServiceProcess;
using System.Text;
using System.IO;
using Ultrasonicsoft.Products.BackupManager;
using System.Timers;

namespace DBBackupMonitor
{
    public partial class DBBackupMonitor : ServiceBase
    {
        Timer scheduler = new Timer();
        TimeSpan scheduledBackupTime = new TimeSpan();

        public DBBackupMonitor()
        {
            InitializeComponent();
        }


        protected override void OnStart(string[] args)
        {
            ReadScheduledBackupTime();
            scheduler.Interval = 100;
            scheduler.Elapsed += new ElapsedEventHandler(scheduler_Elapsed);
            scheduler.Start();

        }

        private void ReadScheduledBackupTime()
        {
            string scheduledTimeString = System.Configuration.ConfigurationManager.AppSettings["ScheduledTime"];
            string[] allParts = scheduledTimeString.Split(':');
            int hour = int.Parse(allParts[0]);
            int minute = int.Parse(allParts[1]);
            int sec = int.Parse(allParts[2]);
            scheduledBackupTime= new TimeSpan(hour, minute, sec);
        }

        void scheduler_Elapsed(object sender, ElapsedEventArgs e)
        {
            if (DateTime.Now.TimeOfDay.Hours == scheduledBackupTime.Hours && DateTime.Now.TimeOfDay.Minutes == scheduledBackupTime.Minutes && 
                    DateTime.Now.TimeOfDay.Seconds== scheduledBackupTime.Seconds )
            {
                string backupFolderName = System.Configuration.ConfigurationManager.AppSettings["BackupFolder"];
                string backupDate = DateTime.Now.ToString("yyyyMMdd");
                string databaseName = System.Configuration.ConfigurationManager.AppSettings["DatabaseName"];
                string dbServerName = System.Configuration.ConfigurationManager.AppSettings["DbServerName"];

                try
                {
                    DBBackupManager dbManager = new DBBackupManager();
                    dbManager.TakeDailyBackupDatabase(backupFolderName, backupDate, databaseName, dbServerName);
                }
                catch (Exception ex)
                {
                    File.AppendAllText(@"c:\temp\error.txt", ex.Message);
                }
            }
        }

        protected override void OnStop()
        {
            scheduler.Stop();
        }
    }
}
