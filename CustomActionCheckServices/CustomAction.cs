using System;
using System.Collections.Generic;
using System.Text;
using Microsoft.Deployment.WindowsInstaller;

namespace CustomActionCheckServices
{
    public class CustomActions
    {
        [CustomAction]
        public static ActionResult CustomActionCheckServices(Session session)
        {
            session.Log("Begin executing CustomActionCheckServices");
            
            session.Log(string.Format("{0}:{1}","value of the property 'Installed'",session["Installed"]));
                
            //add the code here

            session.Log("Ended executing CustomActionCheckServices");
            return ActionResult.Success;
        }

        private static ActionResult InstallAndStartServices(Session session)
        {
            return ActionResult.Success;
        }

        private static ActionResult StopAndUnInstallServices(Session session)
        {
            return ActionResult.Success;
        }
    }
}
