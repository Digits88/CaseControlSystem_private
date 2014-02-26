using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using System.Data.SqlClient;
using System.IO;
using Microsoft.SqlServer.Management.Common;
using Microsoft.SqlServer.Management.Smo;
using Ultrasonicsoft.Products.BackupManager;
using System.Diagnostics;

namespace CaseControl
{
    /// <summary>
    /// Interaction logic for HomePage.xaml
    /// </summary>
    public partial class HomePage : Window
    {
        public ClientInformation clientInfoHandler = null;
        public ClientBilling clientBillingHandler = null;
        public Reports reportsHandler = null;

        public HomePage()
        {
            InitializeComponent();
           
        }

        private void TakeDailyBackupDatabase()
        {
            try
            {
                if (false == IsDatabaseBackupTaken())
                {
                    string dbBackupFolder = System.IO.Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().Location) +
                                        System.IO.Path.DirectorySeparatorChar.ToString() + Constants.DBBackup;

                    string backupPath = dbBackupFolder + System.IO.Path.DirectorySeparatorChar.ToString() +
                                        Constants.DatabaseName + "-" + DateTime.Now.ToString("yyyyMMdd") + Constants.BackupExtension;

                    if (Directory.Exists(dbBackupFolder) == false)
                    {
                        Directory.CreateDirectory(dbBackupFolder);
                    }
                    BackupDatabase(backupPath);

                    SqlParameter pBackupDate = new SqlParameter();
                    pBackupDate.ParameterName = "@backupDate";
                    pBackupDate.Value = DateTime.Now.ToString("yyyyMMdd");

                    DBHelper.ExecuteStoredProcedure(Constants.UpdateDatabaseBackupStatus, pBackupDate);
                }
            }
            catch (Exception ex)
            {
                Helper.LogException(ex);
            }
        }

        public static void BackupDatabase(string backUpFile)
        {
            ServerConnection con = new ServerConnection(Constants.DatabaseServerName);
            Server server = new Server(con);
            Backup source = new Backup();
            source.Action = BackupActionType.Database;
            source.Database = Constants.DatabaseName;
            BackupDeviceItem destination = new BackupDeviceItem(backUpFile, DeviceType.File);
            source.Devices.Add(destination);
            source.SqlBackup(server);
            con.Disconnect();
        }
   
        private bool IsDatabaseBackupTaken()
        {
            bool result = false;
            try
            {
                object backupDate = DBHelper.GetScalarValue(Constants.LAST_DB_BACKUP_Query) ?? string.Empty;

                if (string.IsNullOrEmpty(backupDate.ToString()))
                {
                    return false;
                }
                if (backupDate.ToString().Equals(DateTime.Now.ToString("yyyyMMdd")))
                {
                    result = true;
                }
            }
            catch (Exception ex)
            {
                Helper.LogException(ex);
            }
            return result;
        }

        private void CreateDatabaseStructure()
        {
            try
            {
                StreamReader strReader = new StreamReader(@"QueryFile.txt");
                string str;
                bool result = true;

                while ((str = strReader.ReadLine()) != null & result != false)
                {
                    if (str != "")
                    {
                        result = ExecuteQuery(str);
                        if (result == false)
                            break;
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        public bool ExecuteQuery(string sqlQuery)
        {
            string connection = Properties.Settings.Default.ConnectionString;
            SqlConnection con = new SqlConnection(connection);
            bool result = true;

            SqlCommand cmd = new SqlCommand(sqlQuery, con);

            try
            {
                con.Open();
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                result = false;
                MessageBox.Show(ex.Message);
            }
            finally
            {
                con.Close();
            }

            return result;
        }

        private void btnClientInformation_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                clientInfoHandler = new ClientInformation();
                clientInfoHandler.HomePageHandler = this;
                clientInfoHandler.Show();
            }
            catch (Exception ex)
            {
                Helper.LogException(ex);
            }
        }

        private void btnDeleteClients_Click(object sender, RoutedEventArgs e)
        {
            Login loginForm = new Login();
            loginForm.ShowDialog();
        }

        private void btnBilling_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                clientBillingHandler = new ClientBilling();
                clientBillingHandler.HomePageHandler = this;
                clientBillingHandler.Show();
            }
            catch (Exception ex)
            {
                Helper.LogException(ex);
            }
        }

        private void btnReports_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                reportsHandler = new Reports();
                reportsHandler.HomePageHandler = this;
                reportsHandler.Show();
            }
            catch (Exception ex)
            {
                Helper.LogException(ex);
            }
        }

        private void btnConfigureDatase_Click(object sender, RoutedEventArgs e)
        {
            ConfigureDatabase configure = new ConfigureDatabase();
            configure.ShowDialog();
        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {

        }

        private void btnBackupDatabase_Click(object sender, RoutedEventArgs e)
        {
            DBBackupManager manager = new DBBackupManager();
            string dbBackupFolder = System.IO.Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().Location) +
                                        System.IO.Path.DirectorySeparatorChar.ToString() + Constants.DBBackup;

             string backupFileName = dbBackupFolder + System.IO.Path.DirectorySeparatorChar.ToString() +
                                        Constants.DatabaseName + "-" + DateTime.Now.ToString("yyyyMMdd") + Constants.BackupExtension;

            manager.SetupBackupFolder(dbBackupFolder);
            manager.BackupDatabase(backupFileName, Constants.DatabaseServerName, Constants.DatabaseName);
            string message = "Database backup done! Do you want to open backup folder?";
            var result = MessageBox.Show(message, "Case Control System", MessageBoxButton.YesNo, MessageBoxImage.Question);
            if (result == MessageBoxResult.Yes || result == MessageBoxResult.OK)
            {
                Process.Start(dbBackupFolder);
            }
        }
    }
}
