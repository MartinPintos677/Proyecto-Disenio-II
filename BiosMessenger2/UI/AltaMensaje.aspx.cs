using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using RefServicio;
using System.Xml;
using System.Xml.Linq;

public partial class AltaMensajeComun : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            try
            {
                Session["TiposdeMensaje"] = new ServicioEF().ListarTiposdeMensaje().ToList();
                ddlTiposMensaje.DataSource = Session["TiposdeMensaje"];
                ddlTiposMensaje.DataValueField = "Codigo";
                ddlTiposMensaje.DataTextField = "Nombre";
                ddlTiposMensaje.DataBind();
                LimpioPantalla();
            }
            catch (System.Web.Services.Protocols.SoapException ex)
            {
                lblMensaje.Text = ex.Detail.InnerText;                
            }
            catch (Exception ex)
            {
                lblMensaje.Text = ex.Message;
            }
        }
    }
    protected void LimpioPantalla()
    {
        btnEnviar.Enabled = false;
        lblMensaje.Text = null;
        lblMensaje.CssClass = null;
        txtAsunto.Text = string.Empty;
        txtTextoMensaje.Text = string.Empty;
        txtUsuLogueo.Text = string.Empty;
        txtFCaducidad.Text = string.Empty;
        txtFCaducidad.Focus();
        grvReceptores.DataSource = null;
        grvReceptores.DataBind();
        List<Usuario> listaReceptores = new List<Usuario>();
        Session["ListaReceptores"] = listaReceptores;
    }
    protected void CargoGrilla()
    {
        grvReceptores.DataSource = Session["ListaReceptores"];
        grvReceptores.DataBind();
        btnEnviar.Enabled = true;
        grvReceptores.SelectedIndex = -1;
    }

    protected void btnEnviar_Click(object sender, EventArgs e)
    {
        Mensaje M = null;        
        try
        {
            List<Usuario> listaReceptores = (List<Usuario>)Session["ListaReceptores"];
            Usuario usuario = (Usuario)Session["UsuarioMP"];            
            TipodeMensaje tipoM = ((List<TipodeMensaje>)Session["TiposdeMensaje"])[ddlTiposMensaje.SelectedIndex];

            M = new Mensaje()
            {
                TextoMensaje = txtTextoMensaje.Text,
                Asunto = txtAsunto.Text,                
                FechaCaducidad = Convert.ToDateTime(txtFCaducidad.Text),
                TipodeMensaje = tipoM,
                Reciben = listaReceptores.ToArray(),
                Usuario = usuario                
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
            new ServicioEF().AltaMensaje(M);
            LimpioPantalla();
            lblMensaje.Text = "Mensaje Enviado!";
            lblMensaje.CssClass = "alert alert-success";            
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

    protected void grvReceptores_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            List<Usuario> reciben = (List<Usuario>)Session["ListaReceptores"];            
            Usuario usuario = ((List<Usuario>)Session["ListaReceptores"])[grvReceptores.SelectedIndex];
            reciben.Remove(usuario);
            CargoGrilla();

            if (reciben.Count == 0)
                btnEnviar.Enabled = false;

            lblMensaje.Text = null;
            lblMensaje.CssClass = null;
        }        
        catch (Exception ex)
        {
            lblMensaje.Text = ex.Message;
            lblMensaje.CssClass = "alert alert-warning";
        }
    }

    protected void btnAgregarR_Click(object sender, EventArgs e)
    {
        try
        {
            string logueo = txtUsuLogueo.Text.Trim();

            if (logueo != string.Empty)
            {
                List<Usuario> reciben = (List<Usuario>)Session["ListaReceptores"];

                bool repetido = reciben.Where(u => u.UsuarioLogueo == logueo).Any();

                if (repetido)
                {
                    lblMensaje.Text = "El receptor indicado ya fue agregado a la lista.";
                    lblMensaje.CssClass = "alert alert-warning";
                    return;
                }
                else
                {
                    Usuario usuario = new ServicioEF().BuscarUsuario(logueo);

                    if (usuario != null)
                    {
                        reciben.Add(usuario);
                        CargoGrilla();
                        lblMensaje.Text = null;
                        lblMensaje.CssClass = null;
                    }
                    else
                    {
                        lblMensaje.Text = "Usuario no encontrado en el sistema.";
                        lblMensaje.CssClass = "alert alert-warning";
                    }
                }                
            }
            else
            {
                lblMensaje.Text = "Debe indicar un usuario de logueo.";
                lblMensaje.CssClass = "alert alert-warning";
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
        LimpioPantalla();
    }
}