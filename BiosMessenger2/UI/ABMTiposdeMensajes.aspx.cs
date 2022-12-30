using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using RefServicio;
using System.Xml;
using System.Xml.Linq;

public partial class ABMTiposdeMensajes : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
            Limpio();
    }

    private void Limpio()
    {
        btnBuscar.Enabled = true;
        btnLimpiar.Enabled = false;
        btnAgregar.Enabled = false;
        btnModificar.Enabled = false;
        btnEliminar.Enabled = false;

        txtCodigo.Enabled = true;
        txtNombre.Enabled = false;

        lblMensaje.Text = string.Empty;
        lblMensaje.CssClass = null;
        
        txtNombre.Text = string.Empty;
        txtCodigo.Text = string.Empty;
        txtCodigo.Focus();
    }
    private void BEncontrado()
    {
        btnBuscar.Enabled = false;
        btnLimpiar.Enabled = true;
        btnAgregar.Enabled = false;
        btnModificar.Enabled = true;
        btnEliminar.Enabled = true;
        txtNombre.Enabled = true;        
        txtCodigo.Enabled = true;
        lblMensaje.Text = string.Empty;
        lblMensaje.CssClass = null;
    }
    private void BNoEncontrado()
    {
        btnBuscar.Enabled = false;
        btnLimpiar.Enabled = true;
        btnAgregar.Enabled = true;
        btnEliminar.Enabled = false;
        btnModificar.Enabled = false;
        txtNombre.Enabled = true;        
        txtCodigo.Enabled = true;
        txtNombre.Text = string.Empty;        
        lblMensaje.Text = string.Empty;
        lblMensaje.CssClass = null;
        txtNombre.Focus();
    }

    protected void btnBuscar_Click(object sender, EventArgs e)
    {
        try
        {
            
            if (txtCodigo.Text.Trim() != string.Empty)
            {
                TipodeMensaje unTipo = new ServicioEF().BuscarTipodeMensaje(txtCodigo.Text.Trim());

                if (unTipo == null)
                {
                    BNoEncontrado();
                }
                else
                {
                    BEncontrado();
                    Session["Tipo"] = unTipo;
                    txtNombre.Text = unTipo.Nombre;
                }
            }
            else
            {
                lblMensaje.Text = "Debe ingresar el código de tipo de mensaje.";
                lblMensaje.CssClass = "alert alert-warning"; 
                txtCodigo.Focus();
            }
            
        }
        catch (System.Web.Services.Protocols.SoapException ex)
        {
            lblMensaje.Text = ex.Detail.InnerText;
            lblMensaje.CssClass = "alert alert-warning";
        }
        catch (Exception ex)
        {
            lblMensaje.Text = ex.Message;
            lblMensaje.CssClass = "alert alert-warning";
        }
    }

    protected void btnAgregar_Click(object sender, EventArgs e)
    {
        TipodeMensaje T = null;

        try
        {
            T = new TipodeMensaje()
            {
                Codigo = txtCodigo.Text.Trim(),
                Nombre = txtNombre.Text.Trim()                
            };
        }
        catch (Exception ex)
        {
            lblMensaje.Text = ex.Message;
            lblMensaje.CssClass = "alert alert-warning";
            return;
        }
        try
        {
            new ServicioEF().AltaTipodeMensaje(T);

            Limpio();
            lblMensaje.Text = "Tipo de mensaje registrado exitosamente.";
            lblMensaje.CssClass = "alert alert-success";
            btnLimpiar.Enabled = true;
        }
        catch (System.Web.Services.Protocols.SoapException ex)
        {
            lblMensaje.Text = ex.Detail.InnerText;
            lblMensaje.CssClass = "alert alert-warning";
        }
        catch (Exception ex)
        {
            lblMensaje.Text = ex.Message;
            lblMensaje.CssClass = "alert alert-warning";
        }
    }

    protected void btnEliminar_Click(object sender, EventArgs e)
    {
        try
        {
            TipodeMensaje unTipo = (TipodeMensaje)Session["Tipo"];
            new ServicioEF().EliminarTipodeMensaje(unTipo);

            Limpio();
            lblMensaje.Text = "Tipo de mensaje eliminado.";
            lblMensaje.CssClass = "alert alert-success";
            btnLimpiar.Enabled = true;
        }
        catch (System.Web.Services.Protocols.SoapException ex)
        {
            lblMensaje.Text = ex.Detail.InnerText;
            lblMensaje.CssClass = "alert alert-warning";
        }
        catch (Exception ex)
        {
            lblMensaje.Text = ex.Message;
            lblMensaje.CssClass = "alert alert-warning";
        }
    }

    protected void btnModificar_Click(object sender, EventArgs e)
    {
        try
        {            
            TipodeMensaje unTipo = (TipodeMensaje)Session["Tipo"];
            unTipo.Nombre = txtNombre.Text.Trim();            
            
            new ServicioEF().ModificarTipodeMensaje(unTipo);
            Limpio();
            lblMensaje.Text = "Tipo de mensaje modificado.";
            lblMensaje.CssClass = "alert alert-success";
            btnLimpiar.Enabled = true;
        }
        catch (System.Web.Services.Protocols.SoapException ex)
        {
            lblMensaje.Text = ex.Detail.InnerText;
            lblMensaje.CssClass = "alert alert-warning";
        }
        catch (Exception ex)
        {
            lblMensaje.Text = ex.Message;
            lblMensaje.CssClass = "alert alert-warning";
        }
    }

    protected void btnLimpiar_Click(object sender, EventArgs e)
    {
        Limpio();
    }
}
