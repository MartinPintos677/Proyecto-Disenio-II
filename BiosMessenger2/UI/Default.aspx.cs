using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using RefServicio;
using System.Xml;
using System.Xml.Linq;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Session["UsuarioMP"] = null;
        txtUsuario.Focus();

        if (!IsPostBack)
        {
            try
            {
                lblUsu.Text = new ServicioEF().CantidadUsuarios().ToString();

                lblMensajes.Text = new ServicioEF().CantidadMensajesEnviados().ToString();

                XmlNode _Documento = new ServicioEF().CantidadTipos();
                XElement _documento = XElement.Parse(_Documento.OuterXml);

                List<object> tipos = (from unT in _documento.Elements("Tipos")
                                      select new
                                      {
                                          Tipo = unT.Attribute("TipoM").Value,
                                          Cantidad = unT.Value
                                      }).ToList<object>();

                grvTiposM.DataSource = tipos;
                grvTiposM.DataBind();
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

    protected void btnEntrar_Click(object sender, EventArgs e)
    {
        try
        {
            Usuario usuario = new ServicioEF().LogueoUsuario(txtUsuario.Text.Trim(), txtPass.Text.Trim());

            if (usuario != null)
            {
                Session["UsuarioMP"] = usuario;
                Response.Redirect("~/BandejadeEntrada.aspx");
            }
            else
            {
                lblMensaje.Text = "Usuario y/o contraseña incorrectos.";
                lblMensaje.CssClass = "alert alert-danger";
            }
        }
        catch (System.Web.Services.Protocols.SoapException ex)
        {
            lblMensaje.Text = ex.Detail.InnerText;
            lblMensaje.CssClass = "alert alert-danger";
        }
        catch (Exception ex)
        {
            lblMensaje.Text = ex.Message;
            lblMensaje.CssClass = "alert alert-danger";
        }
    }
}