using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EntidadesCompartidas;
using Logica;

namespace ObligatorioAppWeb
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void BtnLogin_Click(object sender, EventArgs e)
        {
            try
            {
                string _cedula = TBCedula.Text;
                string _pass = TBContrasenia.Text;

                ILogicaEmpleado FEmpleado = FabricaLogica.getLogicaEmpleado();

                Empleados unEmp = FEmpleado.Login(_cedula, _pass);

                if (unEmp != null)
                {
                    Session["Empleado"] = unEmp;
                }
                else
                {
                    LblException.Text = "";
                    LblError.Text = "Cédula y/o contraseña incorrectas.";
                }
            }

            catch
            {
                LblError.Text = "";
                LblException.Text = "Error en la base de datos. Contacte con el administrador.";
            }
        }
    }
}