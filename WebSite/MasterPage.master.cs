using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EntidadesCompartidas;

public partial class MasterPage : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        /*if (Session["Empleado"] == null)
        {
            Response.Redirect("Login.aspx", false);
        }
        else
        {
            if (!IsPostBack)
            {
                Empleados empLogueado = (Empleados)Session["Empleado"];

                LblUser.Text = empLogueado.Nombre;
            }
        }*/
    }


    protected void Menu_MenuItemClick(object sender, MenuEventArgs e)
    {

    }
}
