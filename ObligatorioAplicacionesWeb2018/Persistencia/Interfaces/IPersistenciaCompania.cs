﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using EntidadesCompartidas;

namespace Persistencia.Interfaces
{
    public interface IPersistenciaCompania
    {
        Companias Buscar_Compania(string pNombre);

        Companias BuscarTodos_Compania(string pNombre);

        void Alta_Compania(Companias C);

        void Eliminar_Compania(Companias C);

        void Modificar_Compania(Companias C);
        
        List<Companias> Listar_Companias();

        List<Companias> Listar_Todos_Companias();
    }
}
