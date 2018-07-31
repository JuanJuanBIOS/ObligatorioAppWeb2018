using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using EntidadesCompartidas;

namespace Persistencia.Interfaces
{
    public interface IPersistenciaInternacionales
    {
        Internacionales Buscar_Viaje(int pCodViaje);

        void Alta_Internacional(Internacionales pInternacional);

        void Modificar_Internacional(Internacionales pInternacional);

        void Eliminar_Internacional(Internacionales pInternacional);

        List<Internacionales> Listar_Viajes_Int();
    }
}
