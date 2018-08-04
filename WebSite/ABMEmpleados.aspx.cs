using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Logica.Interfaces;
using Logica;
using EntidadesCompartidas;

public partial class ABMEmpleados : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            TBCedula.Focus();
        }
    }

    protected void BtnBuscar_Click(object sender, EventArgs e)
    {
        if (TBCedula.Text != "")
        {
            try
            {
                LblError.Text = "";

                string _Cedula = Convert.ToString(TBCedula.Text);

                ILogicaEmpleado FEmpleado = FabricaLogica.getLogicaEmpleado();

                Empleados unEmp = FEmpleado.Buscar_Empleado(_Cedula);

                Session["Empleado"] = unEmp;

                if (unEmp == null)
                {
                    ActivoFormularioAlta();
                }

                else
                {
                    TBNombre.Text = unEmp.Nombre;
                    TBContraseña.Text = unEmp.Pass;
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
            string _Cedula = Convert.ToString(TBCedula.Text);
            string _Nombre = Convert.ToString(TBNombre.Text);
            string _Contraseña = Convert.ToString(TBContraseña.Text);

            ILogicaEmpleado FEmpleado = FabricaLogica.getLogicaEmpleado();

            Empleados unEmp = new Empleados(_Cedula, _Contraseña, _Nombre);

            FEmpleado.Alta_Empleado(unEmp);

            LblError.ForeColor = System.Drawing.Color.Blue;
            LblError.Text = "El empleado " + Convert.ToString(unEmp.Nombre) + " ha sido ingresada a la base de datos correctamente.";

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
            string _Cedula = Convert.ToString(TBCedula.Text);
            string _Nombre = Convert.ToString(TBNombre.Text);
            string _Contraseña = Convert.ToString(TBContraseña.Text);

            ILogicaEmpleado FEmpleado = FabricaLogica.getLogicaEmpleado();

            Empleados unEmp = new Empleados(_Cedula, _Contraseña, _Nombre);

            FEmpleado.Modificar_Empleado(unEmp);

            LblError.ForeColor = System.Drawing.Color.Blue;
            LblError.Text = "El empleado " + Convert.ToString(unEmp.Nombre) + " ha sido modificado correctamente.";

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
            Empleados unEmp = (Empleados)Session["Empleado"];

            ILogicaEmpleado FEmpleado = FabricaLogica.getLogicaEmpleado();

            FEmpleado.Eliminar_Empleado(unEmp);

            LblError.ForeColor = System.Drawing.Color.Blue;
            LblError.Text = "La empleado " + Convert.ToString(unEmp.Nombre) + " ha sido eliminada correctamente.";

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
        TBCedula.Text = "";
        TBCedula.Enabled = true;
        BtnBuscar.Enabled = true;
        TBNombre.Text = "";
        TBNombre.Enabled = false;
        TBContraseña.Text = "";
        TBContraseña.Enabled = false;
        BtnAlta.Enabled = false;
        BtnModificar.Enabled = false;
        BtnEliminar.Enabled = false;
        BtnLimpiar.Enabled = true;
    }


    private void ActivoFormularioAlta()
    {
        TBCedula.Enabled = false;
        BtnBuscar.Enabled = false;
        TBNombre.Enabled = true;
        TBContraseña.Enabled = true;
        BtnAlta.Enabled = true;
        BtnModificar.Enabled = false;
        BtnEliminar.Enabled = false;
    }

    private void ActivoFormularioModificacion()
    {
        TBCedula.Enabled = false;
        BtnBuscar.Enabled = false;
        TBNombre.Enabled = true;
        TBContraseña.Enabled = true;
        BtnAlta.Enabled = false;
        BtnModificar.Enabled = true;
        BtnEliminar.Enabled = true;
    }
}

