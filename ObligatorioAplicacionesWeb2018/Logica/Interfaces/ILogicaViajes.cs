using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using EntidadesCompartidas; 

namespace Logica.Interfaces
{
    public interface ILogicaViajes
    {
        Viajes Buscar_Viaje(int pCodViaje);

        void Alta_Viaje(Viajes pViaje);

        void Modificar_Viaje(Viajes pViaje);

        void Eliminar_Viaje(Viajes pViaje);

        List<Viajes> Listar_Viajes();
    }
}
