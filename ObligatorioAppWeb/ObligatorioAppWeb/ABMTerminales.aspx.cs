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
    public partial class ABMTerminales : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                TBCodigo.Focus();
                List<string> Facilidades = new List<string>();

                Session["Facilidades"] = Facilidades;
            }
        }

        protected void BtnAgregar_Click(object sender, EventArgs e)
        {
            if (TBFacilidades.Text != "")
            {
                if (!((List<string>)Session["Facilidades"]).Contains(TBFacilidades.Text))
                {
                    ((List<string>)Session["Facilidades"]).Add(TBFacilidades.Text);
                    LBFacilidades.DataSource = (List<string>)Session["Facilidades"];
                    LBFacilidades.DataBind();
                }
                TBFacilidades.Text = "";
            }
        }

        protected void BtnQuitar_Click(object sender, EventArgs e)
        {
            if (LBFacilidades.SelectedItem != null)
            {
                ((List<string>)Session["Facilidades"]).Remove(LBFacilidades.SelectedItem.ToString());
                LBFacilidades.DataSource = (List<string>)Session["Facilidades"];
                LBFacilidades.DataBind();
            }
        }

        protected void BtnAlta_Click(object sender, EventArgs e)
        {
            try
            {
                string _Codigo = Convert.ToString(TBCodigo.Text);
                string _Ciudad = Convert.ToString(TBCiudad.Text);
                string _Pais = Convert.ToString(TBPais.Text);
                List<string> _Facilidades = (List<string>)Session["Facilidades"];

                Terminales unaTer = new Terminales(_Codigo, _Ciudad, _Pais, _Facilidades);

                ILogicaTerminales FTerminal = FabricaLogica.getLogicaTerminal();

                FTerminal.Alta_Terminal(unaTer);

                LblError.ForeColor = System.Drawing.Color.Blue;
                LblError.Text = "La Terminal ha sido ingresada a la base de datos correctamente.";
                TBCodigo.Enabled = false;
                TBCiudad.Enabled = false;
                TBPais.Enabled = false;
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
            Response.Redirect("ABMTerminales.aspx", false);
        }
    }
}