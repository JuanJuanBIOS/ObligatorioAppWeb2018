using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Logica.Interfaces;
using Logica;
using EntidadesCompartidas;

public partial class ABMTerminales : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LimpioFormulario();
            TBCodigo.Focus();
        }
    }

    protected void BtnBuscar_Click(object sender, EventArgs e)
    {
        if (TBCodigo.Text != "")
        {
            try
            {
                LblError.Text = "";

                string _Codigo = Convert.ToString(TBCodigo.Text);

                ILogicaTerminales FTerminal = FabricaLogica.getLogicaTerminal();

                Terminales unaTer = FTerminal.Buscar_Terminal(_Codigo);

                Session["Terminal"] = unaTer;

                if (unaTer == null)
                {
                    Session["Facilidades"] = new List<Facilidades>();
                    ActivoFormularioAlta();
                }

                else
                {
                    TBCiudad.Text = unaTer.Ciudad;
                    DDLPais.Text = unaTer.Pais;

                    Session["Facilidades"] = unaTer.ListaFacilidades;

                    LBFacilidades.DataSource = unaTer.ListaFacilidades;
                    LBFacilidades.DataTextField = "Facilidad";
                    LBFacilidades.DataBind();

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

    protected void BtnAgregar_Click(object sender, EventArgs e)
    {
        if (TBFacilidades.Text != "")
        {
            Facilidades _facilidad = new Facilidades(TBFacilidades.Text);
            bool encontrado = false;

            if (((List<Facilidades>)Session["Facilidades"]).Count() > 0)
            {
                int posicion = 0;

                do
                    if (_facilidad.Facilidad == ((List<Facilidades>)Session["Facilidades"])[posicion].Facilidad)
                    {
                        encontrado = true;
                    }
                    else
                    {
                        posicion++;
                    }
                while ((!encontrado) && (posicion < ((List<Facilidades>)Session["Facilidades"]).Count()));
            }

            if (!encontrado)
            {
                ((List<Facilidades>)Session["Facilidades"]).Add(_facilidad);
                LBFacilidades.DataSource = (List<Facilidades>)Session["Facilidades"];
                LBFacilidades.DataTextField = "Facilidad";
                LBFacilidades.DataBind();
            }

            TBFacilidades.Text = "";
            TBFacilidades.Focus();
        }
    }

    protected void BtnQuitar_Click(object sender, EventArgs e)
    {
        if (LBFacilidades.SelectedItem != null)
        {
            ((List<Facilidades>)Session["Facilidades"]).RemoveAt(LBFacilidades.SelectedIndex);
            LBFacilidades.DataSource = (List<Facilidades>)Session["Facilidades"];
            LBFacilidades.DataBind();
        }
        TBFacilidades.Focus();
    }

    protected void BtnAlta_Click(object sender, EventArgs e)
    {
        try
        {
            string _Codigo = Convert.ToString(TBCodigo.Text);
            string _Ciudad = Convert.ToString(TBCiudad.Text);
            string _Pais = Convert.ToString(DDLPais.Text);

            List<Facilidades> _Facilidades = new List<Facilidades>();
            _Facilidades = (List<Facilidades>)Session["Facilidades"];

            Terminales unaTer = new Terminales(_Codigo, _Ciudad, _Pais, _Facilidades);

            ILogicaTerminales FTerminal = FabricaLogica.getLogicaTerminal();

            FTerminal.Alta_Terminal(unaTer);

            LblError.ForeColor = System.Drawing.Color.Blue;
            LblError.Text = "La Terminal " + Convert.ToString(unaTer.Codigo) + " ha sido ingresada a la base de datos correctamente.";

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
            string _Codigo = Convert.ToString(TBCodigo.Text);
            string _Ciudad = Convert.ToString(TBCiudad.Text);
            string _Pais = Convert.ToString(DDLPais.Text);

            List<Facilidades> _Facilidades = new List<Facilidades>();
            _Facilidades = (List<Facilidades>)Session["Facilidades"];

            Terminales unaTer = new Terminales(_Codigo, _Ciudad, _Pais, _Facilidades);

            ILogicaTerminales FTerminal = FabricaLogica.getLogicaTerminal();

            FTerminal.Modificar_Terminal(unaTer);

            LblError.ForeColor = System.Drawing.Color.Blue;
            LblError.Text = "La Terminal " + Convert.ToString(unaTer.Codigo) + " ha sido modificada correctamente.";

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
            Terminales unaTer = (Terminales)Session["Terminal"];

            ILogicaTerminales FTerminal = FabricaLogica.getLogicaTerminal();

            FTerminal.Eliminar_Terminal(unaTer);

            LblError.ForeColor = System.Drawing.Color.Blue;
            LblError.Text = "La Terminal " + Convert.ToString(unaTer.Codigo) + " ha sido eliminada correctamente.";

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
        Response.Redirect("ABMTerminales.aspx", false);
    }

    private void LimpioFormulario()
    {
        TBCodigo.Text = "";
        TBCodigo.Enabled = true;
        BtnBuscar.Enabled = true;
        TBCiudad.Text = "";
        TBCiudad.Enabled = false;
        DDLPais.Text = "";
        DDLPais.Enabled = false;
        TBFacilidades.Text = "";
        TBFacilidades.Enabled = false;
        BtnAgregar.Enabled = false;
        LBFacilidades.Items.Clear();
        LBFacilidades.Enabled = false;
        BtnQuitar.Enabled = false;
        BtnAlta.Enabled = false;
        BtnModificar.Enabled = false;
        BtnEliminar.Enabled = false;
        BtnLimpiar.Enabled = true;
    }


    private void ActivoFormularioAlta()
    {
        TBCodigo.Text = TBCodigo.Text.ToUpper();
        TBCodigo.Enabled = false;
        BtnBuscar.Enabled = false;
        TBCiudad.Enabled = true;
        DDLPais.Enabled = true;
        TBFacilidades.Enabled = true;
        BtnAgregar.Enabled = true;
        LBFacilidades.Enabled = true;
        BtnQuitar.Enabled = true;
        BtnAlta.Enabled = true;
        BtnModificar.Enabled = false;
        BtnEliminar.Enabled = false;
    }

    private void ActivoFormularioModificacion()
    {
        TBCodigo.Enabled = false;
        BtnBuscar.Enabled = false;
        TBCiudad.Enabled = true;
        DDLPais.Enabled = true;
        TBFacilidades.Enabled = true;
        BtnAgregar.Enabled = true;
        LBFacilidades.Enabled = true;
        BtnQuitar.Enabled = true;
        BtnAlta.Enabled = false;
        BtnModificar.Enabled = true;
        BtnEliminar.Enabled = true;
    }
}