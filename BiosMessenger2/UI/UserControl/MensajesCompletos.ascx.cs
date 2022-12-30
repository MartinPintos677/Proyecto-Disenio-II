using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using RefServicio;
using System.Xml;
using System.Xml.Linq;

public partial class UserControl_MensajesCompletos : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    public void CargoUC()
    {
        try
        {
            Mensaje mensaje = (Mensaje)Session["Mensaje"];

            if (mensaje != null)
            {
                lblCod.Text = "Código: ";
                lblFec.Text = "Fecha: ";
                lblAsu.Text = "Asunto: ";
                lblTex.Text = "Texto: ";
                lblTipo.Text = "Tipo de mensaje: ";

                lblTexto.Text = mensaje.TextoMensaje;
                lblCodigo.Text = mensaje.Codigo.ToString();
                lblAsunto.Text = mensaje.Asunto;
                lblFecha.Text = mensaje.FechaHora.ToString();
                lblTip.Text = mensaje.TipodeMensaje.Nombre;
                               
                grvReciben.DataSource = new ServicioEF().Destinatarios(mensaje).ToList();
                grvReciben.DataBind();
            }
            else
            {
                lblCod.Text = string.Empty;
                lblFec.Text = string.Empty;
                lblAsu.Text = string.Empty;
                lblTex.Text = string.Empty;
                lblTipo.Text = string.Empty;

                lblTexto.Text = string.Empty;
                lblCodigo.Text = string.Empty;
                lblAsunto.Text = string.Empty;
                lblFecha.Text = string.Empty;
                lblTip.Text = string.Empty;

                grvReciben.DataSource = null;
                grvReciben.DataBind();
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
}