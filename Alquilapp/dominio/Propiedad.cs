using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace dominio
{
    public class Propiedad
    {

        public int IdPropiedad { get; set; }
        public int IdAnfitrion { get; set; }   

        public string Titulo { get; set; }
        public string Descripcion { get; set; }
        public decimal PrecioNoche { get; set; }
        public int Capacidad { get; set; }
        public string TipoPropiedad { get; set; }
        public string Direccion { get; set; }
        public bool Activa { get; set; }

        // Relaciones opcionales
        public Ciudad Ciudad { get; set; }
        public Usuario Anfitrion { get; set; }
        public List<FotoPropiedad> Fotos { get; set; } = new List<FotoPropiedad>();
        public List<Reserva> Reservas { get; set; } = new List<Reserva>();

       
    }

}

