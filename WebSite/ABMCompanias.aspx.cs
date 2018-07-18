using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Logica.Interfaces;
using Logica;
using EntidadesCompartidas;

public partial class ABMCompanias : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            TBNombre.Focus();
            Session["Companias"] = null;
        }
    }



    protected void BtnAlta_Click(object sender, EventArgs e)
    {
        try
        {
            string _Nombre = Convert.ToString(TBNombre.Text);
            string _Direccion = Convert.ToString(TBDireccion.Text);
            string _Telefono = Convert.ToString(TBTelefono.Text);

            Companias unaComp = new Companias(_Nombre, _Direccion, _Telefono);

            ILogicaCompania FCompania = FabricaLogica.getLogicaCompania();

            FCompania.Alta_Compania(unaComp);

            LblError.ForeColor = System.Drawing.Color.Blue;
            LblError.Text = "La Compania ha sido ingresada a la base de datos correctamente.";
            TBNombre.Enabled = false;
            TBDireccion.Enabled = false;
            TBTelefono.Enabled = false;
            BtnOk.Visible = true;
        }

        catch (Exception ex)
        {
            LblError.Text = "";
            LblError.Text = "Error en la base de datos. Contacte con el administrador.";
        }
    }

    protected void BtnOk_Click(object sender, EventArgs e)
    {
        Response.Redirect("ABMCompanias.aspx", false);
    }

    protected void BtnBuscar_Click(object sender, EventArgs e)
    {

    }
}