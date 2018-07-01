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
                //Verifico el usuario y contraseña
                Empleados unEmp = LogicaEmpleado.Login(TBCedula.Text, TBContrasenia.Text);
                if (unEmp != null)
                {
                    Session["Empleado"] = unEmp;
                //    if (unUsu is Administrador)
                //    {
                //        Response.Redirect("BienvenidaAdministrador.aspx", false);
                //    }
                //    else if (unUsu is Cliente)
                //    {
                //        Response.Redirect("BienvenidaCliente.aspx", false);
                //    }
                //    else
                //    {
                //        Response.Redirect("Login.aspx", false);
                //    }
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