﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace EntidadesCompartidas
{
    public class Viajes
    {
        //Atributos
        private int _numero;
        private Companias _compania;
        private Terminales _destino;
        private DateTime _fecha_partida;
        private DateTime _fecha_arribo;
        private int _asientos;
        private Empleados _empleado;


        //Propiedades
        public int Numero
        {
            get {return _numero;}

            set
            {       
                if (value > 0)
                    _numero = value;
                else
                    throw new Exception("El número de viaje no es válido");
            }
        }

        public Companias Compania
        {
            get {return _compania;}

            set
            {
                if (value != null)
                {
                    _compania = value;
                }
                else
                {
                    throw new Exception("La compañía ingresada no es válida");
                }
            }
        }

        public Terminales Terminal
        {
            get {return _destino;}

            set
            {
                if (value != null)
                {
                    _destino = value;
                }
                else
                {
                    throw new Exception("La terminal ingresada no es válida");
                }
            }
        }

        public DateTime Fecha_partida
        {
            get {return _fecha_partida;} //FALTA VERIFICAR QUE SEA POSTERIOR AL DÍA DE HOY Y ADEMÁS VER SI SE PUEDE VERIFICAR QUE SEA ANTERIOR A LA DE ARRIBO

            set {_fecha_partida = value;}
        }

        public DateTime Fecha_arribo
        {
            get { return _fecha_arribo; } //FALTA VERIFICAR QUE SEA POSTERIOR AL DÍA DE HOY Y ADEMÁS VER SI SE PUEDE VERIFICAR QUE SEA POSTERIOR A LA DE PARTIDA

            set {_fecha_arribo = value;}
        }

        public int Asientos
        {
            get {return _asientos;}

            set
            {       
                if (value > 0)
                    _asientos = value;
                else
                    throw new Exception("El número de asientos no es válido");
            }
        }

        public Empleados Empleado
        {
            get {return _empleado;}

            set
            {
                if (value != null)
                {
                    _empleado = value;
                }
                else
                {
                    throw new Exception("El empleado ingresado no es válido");
                }
            }
        }


       //Constructor
        public Viajes(int pNumero, Companias pCompania, Terminales pTerminal, DateTime pFecha_partida, DateTime pFecha_arribo, int pAsientos, Empleados pEmpleado)
        {
            Numero = pNumero;
            Compania = pCompania;
            Terminal = pTerminal;
            Fecha_partida = pFecha_partida;
            Fecha_arribo = pFecha_arribo;
            Asientos = pAsientos;
            Empleado = pEmpleado;
        }
    }
}
