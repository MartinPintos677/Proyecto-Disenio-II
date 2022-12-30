using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Text.RegularExpressions;

namespace ModeloEF
{
    public class Validar
    {
        public static void ValidarUsuario(Usuario usuario)
        {
            if (usuario.UsuarioLogueo.Trim().Length != 8)
                throw new Exception("Logueo de usuario debe tener 8 caracteres.");

            Regex regexPass = new Regex("[a-zA-Z][a-zA-Z][a-zA-Z][a-zA-Z][a-zA-Z][0-9]");

            if (!regexPass.IsMatch(usuario.Contrasena))
            {
                throw new Exception("La contraseña debe tener 6 caracteres, los primeros 5 deben ser letras y el " +
                                    "último debe ser un número.");
            }

            if (usuario.Nombre == string.Empty)            
                throw new Exception("Debe indicar un nombre.");            

            if (usuario.Nombre.Trim().Length > 50)            
                throw new Exception("El nombre no debe tener más de 50 caracteres.");

            if (usuario.Apellido == string.Empty)            
                throw new Exception("Debe indicar un apellido.");
            
            if (usuario.Apellido.Trim().Length > 50)            
                throw new Exception("El apellido no puede tener más de 50 caracteres.");

            Regex regexMail1 = new Regex(@"^[^\s@]+@[^\s@]+\.[^\s@]+$");
            Regex regexMail2 = new Regex(@"^[^\s@]+@[^\s@]+\.[^\s@]+\.[^\s@]+$");

            if (usuario.Mail == string.Empty)            
                throw new Exception("Debe indicar un mail.");
            
            if (usuario.Mail.Trim().Length > 50)            
                throw new Exception("El mail no puede tener más de 50 caracteres.");
            
            if (!regexMail1.IsMatch(usuario.Mail) && !regexMail2.IsMatch(usuario.Mail))            
                throw new Exception("Mail incorrecto.");            
        }

        public static void ValidarTiposMensaje(TipodeMensaje tipos)
        {
            Regex regex = new Regex("[a-zA-Z][a-zA-Z][a-zA-Z]");

            if (!regex.IsMatch(tipos.Codigo))            
                throw new Exception("El código debe tener 3 letras.");

            if (tipos.Nombre == string.Empty)            
                throw new Exception("Debe ingresar nombre para el tipo de mensaje.");
           
            if (tipos.Nombre.Trim().Length > 20)            
                throw new Exception("Nombre de tipo de mensaje no debe tener más de 20 caracteres.");            
        }

        public static void ValidarMensaje(Mensaje mensaje)
        {            
            if (mensaje.TextoMensaje == string.Empty)            
                throw new Exception("Debe ingresar texto para el mensaje.");

            if (mensaje.Asunto == string.Empty)            
                throw new Exception("Debe ingresar asunto para el mensaje.");
            
            if (mensaje.Asunto.Trim().Length > 30)            
                throw new Exception("El asunto debe tener un máximo de 30 caracteres.");
            
            if (mensaje.TipodeMensaje == null)
                throw new Exception("Debe indicar el tipo de mensaje.");

            if (mensaje.Usuario == null)            
                throw new Exception("Debe indicar un Usuario.");

            if (mensaje.Reciben == null || mensaje.Reciben.Count() == 0)            
                throw new Exception("La cantidad de usuarios receptores de mensaje no puede ser 0.");
        }
    }
}
