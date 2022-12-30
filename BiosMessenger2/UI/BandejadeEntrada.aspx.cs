using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using RefServicio;
using System.Xml;
using System.Xml.Linq;

public partial class BandejadeEntrada : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            try
            {
                Usuario usuario = (Usuario)Session["UsuarioMP"];
                Session["ListaRecibidos"] = new ServicioEF().ListarMensajesRecibidos(usuario).ToList();

                Session["Tipos"] = new ServicioEF().ListarTiposdeMensaje().ToList();
                ddlTiposMensaje.DataSource = Session["Tipos"];
                ddlTiposMensaje.DataValueField = "Codigo";
                ddlTiposMensaje.DataTextField = "Nombre";
                ddlTiposMensaje.DataBind();

                Limpiar();
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
    }
    private void Limpiar()
    {        
        Session["OtraLista"] = null;

        List<Mensaje> lista = (List<Mensaje>)Session["ListaRecibidos"];
        if (lista.Count == 0)
        {
            lblMensaje.Text = "Ningún mensaje recibido.";
            lblMensaje.CssClass = "alert alert-primary";
        }
        else
        {
            grvRecibidos.DataSource = Session["ListaRecibidos"];
            grvRecibidos.DataBind();
            lblMensaje.Text = string.Empty;
            lblMensaje.CssClass = null;
        }

        Session["Mensaje"] = null;
        MensajesCompletos1.CargoUC();
        grvRecibidos.SelectedIndex = -1;

        ddlTiposMensaje.SelectedIndex = 0;
        btnLimpiar.Enabled = false;
        txtFecha.Text = string.Empty;
        txtFecha.Focus();
    }

    private void CargoGrilla()
    {
        Session["Mensaje"] = null;
        grvRecibidos.DataSource = Session["OtraLista"];
        grvRecibidos.DataBind();
        grvRecibidos.SelectedIndex = -1;
        MensajesCompletos1.CargoUC();
        lblMensaje.Text = string.Empty;
        lblMensaje.CssClass = null;
        btnLimpiar.Enabled = true;
    }
    private void SinMensajes()
    {
        btnLimpiar.Enabled = true;
        Session["Mensaje"] = null;
        MensajesCompletos1.CargoUC();
        grvRecibidos.DataSource = null;
        grvRecibidos.DataBind();        
    }
    protected void grvRecibidos_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            List<Mensaje> mensajes = (List<Mensaje>)Session["OtraLista"];
            Mensaje mensaje = null;

            if (mensajes == null)
            {
                mensaje = ((List<Mensaje>)Session["ListaRecibidos"])[grvRecibidos.SelectedIndex];
            }
            else
            {
                mensaje = ((List<Mensaje>)Session["OtraLista"])[grvRecibidos.SelectedIndex];
            }

            Session["Mensaje"] = mensaje;
            MensajesCompletos1.CargoUC();

            btnLimpiar.Enabled = true;
            lblMensaje.Text = string.Empty;
            lblMensaje.CssClass = null;
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
    protected void btnFecha_Click(object sender, EventArgs e)
    {
        try
        {
            Usuario usuario = (Usuario)Session["UsuarioMP"];

            TipodeMensaje tipoM = null;

            DateTime fecha = new DateTime();

            if (ddlTiposMensaje.SelectedIndex > 0)
                tipoM = ((List<TipodeMensaje>)Session["Tipos"])[ddlTiposMensaje.SelectedIndex - 1];

            if (txtFecha.Text.Trim() != string.Empty)
                fecha = Convert.ToDateTime(txtFecha.Text.Trim());

            List<Mensaje> filtros = new ServicioEF().ListarRecibidosTipoFecha(usuario, tipoM, fecha).ToList();

            if (filtros.Count == 0)
            {
                lblMensaje.Text = "Ningún mensaje en el filtro seleccionado.";
                lblMensaje.CssClass = "alert alert-primary";
                SinMensajes();
            }
            else
            {
                Session["OtraLista"] = filtros;
                CargoGrilla();
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

    protected void btnLimpiar_Click(object sender, EventArgs e)
    {
        Limpiar();
    }
}