using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace EntidadesCompartidas
{
    public abstract class Viajes
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
            get { return _numero; }

            set
            {
                try
                {
                    if (Convert.ToInt32(value) > 0)
                    {
                        _numero = value;
                    }
                    else
                    {
                        throw new Exception("El número de viaje ingresado no es válido");
                    }
                }

                catch
                {
                    throw new Exception("El número de viaje ingresado no es válido");
                }
            }
        }

        public Companias Compania
        {
            get { return _compania; }

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
            get { return _destino; }

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
            get { return _fecha_partida; }

            set
            {
                _fecha_partida = value;
            }
        }

        public DateTime Fecha_arribo
        {
            get { return _fecha_arribo; }

            set
            {
                if (value >= _fecha_partida)
                {
                    _fecha_arribo = value;
                }
                else
                {
                    throw new Exception("La fecha de arribo no puede ser anterior a la fecha de partida");
                }
            }
        }

        public int Asientos
        {
            get { return _asientos; }

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
            get { return _empleado; }

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
