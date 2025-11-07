using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace dominio
{
    public class Usuario
    {
        public int IdUsuario { get; set; }
        public string Nombre { get; set; }
        public string Apellido { get; set; }
        public string Email { get; set; }       
        public string Telefono { get; set; }
        public DateTime FechaRegistro { get; set; }
        public DateTime? UltimoLogin { get; set; }
        public bool Activo { get; set; }

        // Un usuario puede tener múltiples roles
        public List<string> Roles { get; set; } = new List<string>();
        public List<Propiedad> Propiedades { get; set; } = new List<Propiedad>();
        public List<Reserva> Reservas { get; set; } = new List<Reserva>();

    }
}