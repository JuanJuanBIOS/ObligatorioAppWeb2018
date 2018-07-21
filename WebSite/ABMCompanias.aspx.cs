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
        }
    }

    protected void BtnBuscar_Click(object sender, EventArgs e)
    {
        if (TBNombre.Text != "")
        {
            try
            {
                LblError.Text = "";

                string _Nombre = Convert.ToString(TBNombre.Text);

                ILogicaCompania FCompania = FabricaLogica.getLogicaCompania();

                Companias unaComp = FCompania.Buscar_Compania(_Nombre);

                Session["Compania"] = unaComp;

                if (unaComp == null)
                {
                    ActivoFormularioAlta();
                }

                else
                {
                    TBDireccion.Text = unaComp.Direccion;
                    TBTelefono.Text = unaComp.Telefono;
                    ActivoFormularioModificacion();
                }
            }

            catch (Exception ex)
            {
                LblError.ForeColor = System.Drawing.Color.Red;
                LblError.Text = ex.Message;
            }
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
            LblError.Text = "La Compania " + Convert.ToString(unaComp.Nombre) + " ha sido ingresada a la base de datos correctamente.";

            LimpioFormulario();
        }

        catch (Exception ex)
        {
            LblError.ForeColor = System.Drawing.Color.Red;
            LblError.Text = ex.Message;
        }
    }




    protected void BtnModificar_Click(object sender, EventArgs e)
    {
        try
        {
            string _Nombre = Convert.ToString(TBNombre.Text);
            string _Direccion = Convert.ToString(TBDireccion.Text);
            string _Telefono = Convert.ToString(TBTelefono.Text);

            Companias unaComp = new Companias(_Nombre, _Direccion, _Telefono);

            ILogicaCompania FCompania = FabricaLogica.getLogicaCompania();

            FCompania.Modificar_Compania(unaComp);

            LblError.ForeColor = System.Drawing.Color.Blue;
            LblError.Text = "La Compania " + Convert.ToString(unaComp.Nombre) + " ha sido modificada correctamente.";

            LimpioFormulario();
        }

        catch (Exception ex)
        {
            LblError.ForeColor = System.Drawing.Color.Red;
            LblError.Text = ex.Message;
        }
    }



    protected void BtnEliminar_Click(object sender, EventArgs e)
    {
        try
        {
            Companias unaComp = (Companias)Session["Compania"];

            ILogicaCompania FCompania = FabricaLogica.getLogicaCompania();

            FCompania.Eliminar_Compania(unaComp);

            LblError.ForeColor = System.Drawing.Color.Blue;
            LblError.Text = "La Compania " + Convert.ToString(unaComp.Nombre) + " ha sido eliminada correctamente.";

            LimpioFormulario();
        }

        catch (Exception ex)
        {
            LblError.ForeColor = System.Drawing.Color.Red;
            LblError.Text = ex.Message;
        }
    }


    protected void BtnLimpiar_Click(object sender, EventArgs e)
    {
        LimpioFormulario();

    }

    private void LimpioFormulario()
    {
        TBNombre.Text = "";
        TBNombre.Enabled = true;
        BtnBuscar.Enabled = true;
        TBDireccion.Text = "";
        TBDireccion.Enabled = false;
        TBTelefono.Text = "";
        TBTelefono.Enabled = false;
        BtnAlta.Enabled = false;
        BtnModificar.Enabled = false;
        BtnEliminar.Enabled = false;
        BtnLimpiar.Enabled = true;
    }


    private void ActivoFormularioAlta()
    {
        TBNombre.Enabled = false;
        BtnBuscar.Enabled = false;
        TBDireccion.Enabled = true;
        TBTelefono.Enabled = true;
        BtnAlta.Enabled = true;
        BtnModificar.Enabled = false;
        BtnEliminar.Enabled = false;
    }

    private void ActivoFormularioModificacion()
    {
        TBNombre.Enabled = false;
        BtnBuscar.Enabled = false;
        TBDireccion.Enabled = true;
        TBTelefono.Enabled = true;
        BtnAlta.Enabled = false;
        BtnModificar.Enabled = true;
        BtnEliminar.Enabled = true;
    }

}