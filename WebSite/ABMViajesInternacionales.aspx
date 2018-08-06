<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ABMViajesInternacionales.aspx.cs" Inherits="ABMViajesInternacionales" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PaginaPrincipal" runat="server">
                <h2 align="center">
                    <asp:Label ID="LbSubt" runat="server" 
                    Text="Mantenimiento de Viajes Internacionales"></asp:Label>
                </h2>
    <table>
        <tr>
            <td align="center" valign="middle" style="width: 142px; text-align: left;">
                <asp:Label ID="LBNumero" runat="server" Text="Número: "></asp:Label>
            </td>
            <td align="left" valign="middle" colspan="2">
                <asp:TextBox 
        ID="TBNumero" runat="server"></asp:TextBox>
            </td>
            <td align="left" valign="middle" colspan="3">
    <asp:Button ID="BtnBuscar" runat="server" Text="Buscar" onclick="BtnBuscar_Click" 
       />
            </td>
        </tr>
        <tr>
            <td align="center" valign="middle" style="height: 23px;" colspan="6">
                &nbsp;</td>
        </tr>
        <tr>
            <td align="center" valign="middle" style="text-align: left;" colspan="6">
        <asp:Label ID="LblError" runat="server" ForeColor="Red" style="text-align: left"></asp:Label>
            </td>
        </tr>
        <tr>
            <td align="center" valign="middle" colspan="6">
            </td>
        </tr>
        <tr>
            <td align="center" valign="middle" style="width: 142px; text-align: left;">
                <asp:Label ID="LBCompania" runat="server" Text="Compañía: " 
                    style="text-align: left"></asp:Label>
            </td>
            <td align="left" valign="middle" colspan="5">
                <asp:DropDownList ID="DDLCompania" runat="server" Width="240px">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td align="center" valign="middle" style="width: 142px; text-align: left;">
                <asp:Label ID="LBTerminal" runat="server" Text="Terminal: "></asp:Label>
            </td>
            <td align="left" valign="middle" colspan="5">
                <asp:DropDownList ID="DDLTerminal" runat="server" Enabled="False" Width="240px">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td align="center" valign="middle" colspan="6">
            </td>
        </tr>
        <tr>
            <td align="left" valign="middle" colspan="2" style="width: 175px">
                    <asp:Label ID="LbFechaPartida" runat="server" Text="Fecha Partida"></asp:Label>
                    <br />
                    <asp:TextBox ID="TBFechaPartida" runat="server" Enabled="False"></asp:TextBox>
                    <br />
                    <br />
                    <br />
                <asp:Label ID="LBHoraPartida" runat="server" Text="Hora Partida"></asp:Label>
                    <br />
                <asp:DropDownList ID="DDLHoraPartida" runat="server" Enabled="False" 
                    Width="70px" onselectedindexchanged="DDLHoraPartida_SelectedIndexChanged" 
                    AutoPostBack="True">
                    <asp:ListItem>00</asp:ListItem>
                    <asp:ListItem>01</asp:ListItem>
                    <asp:ListItem>02</asp:ListItem>
                    <asp:ListItem>03</asp:ListItem>
                    <asp:ListItem>04</asp:ListItem>
                    <asp:ListItem>05</asp:ListItem>
                    <asp:ListItem>06</asp:ListItem>
                    <asp:ListItem>07</asp:ListItem>
                    <asp:ListItem>08</asp:ListItem>
                    <asp:ListItem>09</asp:ListItem>
                    <asp:ListItem>10</asp:ListItem>
                    <asp:ListItem>11</asp:ListItem>
                    <asp:ListItem>12</asp:ListItem>
                    <asp:ListItem>13</asp:ListItem>
                    <asp:ListItem>14</asp:ListItem>
                    <asp:ListItem>15</asp:ListItem>
                    <asp:ListItem>16</asp:ListItem>
                    <asp:ListItem>17</asp:ListItem>
                    <asp:ListItem>18</asp:ListItem>
                    <asp:ListItem>19</asp:ListItem>
                    <asp:ListItem>20</asp:ListItem>
                    <asp:ListItem>21</asp:ListItem>
                    <asp:ListItem>22</asp:ListItem>
                    <asp:ListItem>23</asp:ListItem>
                </asp:DropDownList>
                &nbsp;:
                <asp:DropDownList ID="DDLMinutosPartida" runat="server" Enabled="False" 
                    Width="70px" 
                    onselectedindexchanged="DDLMinutosPartida_SelectedIndexChanged" 
                    AutoPostBack="True">
                    <asp:ListItem>00</asp:ListItem>
                    <asp:ListItem>01</asp:ListItem>
                    <asp:ListItem>02</asp:ListItem>
                    <asp:ListItem>03</asp:ListItem>
                    <asp:ListItem>04</asp:ListItem>
                    <asp:ListItem>05</asp:ListItem>
                    <asp:ListItem>06</asp:ListItem>
                    <asp:ListItem>07</asp:ListItem>
                    <asp:ListItem>08</asp:ListItem>
                    <asp:ListItem>09</asp:ListItem>
                    <asp:ListItem>10</asp:ListItem>
                    <asp:ListItem>11</asp:ListItem>
                    <asp:ListItem>12</asp:ListItem>
                    <asp:ListItem>13</asp:ListItem>
                    <asp:ListItem>14</asp:ListItem>
                    <asp:ListItem>15</asp:ListItem>
                    <asp:ListItem>16</asp:ListItem>
                    <asp:ListItem>17</asp:ListItem>
                    <asp:ListItem>18</asp:ListItem>
                    <asp:ListItem>19</asp:ListItem>
                    <asp:ListItem>20</asp:ListItem>
                    <asp:ListItem>21</asp:ListItem>
                    <asp:ListItem>22</asp:ListItem>
                    <asp:ListItem>23</asp:ListItem>
                    <asp:ListItem>24</asp:ListItem>
                    <asp:ListItem>25</asp:ListItem>
                    <asp:ListItem>26</asp:ListItem>
                    <asp:ListItem>27</asp:ListItem>
                    <asp:ListItem>28</asp:ListItem>
                    <asp:ListItem>29</asp:ListItem>
                    <asp:ListItem>30</asp:ListItem>
                    <asp:ListItem>31</asp:ListItem>
                    <asp:ListItem>32</asp:ListItem>
                    <asp:ListItem>33</asp:ListItem>
                    <asp:ListItem>34</asp:ListItem>
                    <asp:ListItem>35</asp:ListItem>
                    <asp:ListItem>36</asp:ListItem>
                    <asp:ListItem>37</asp:ListItem>
                    <asp:ListItem>38</asp:ListItem>
                    <asp:ListItem>39</asp:ListItem>
                    <asp:ListItem>40</asp:ListItem>
                    <asp:ListItem>41</asp:ListItem>
                    <asp:ListItem>42</asp:ListItem>
                    <asp:ListItem>43</asp:ListItem>
                    <asp:ListItem>44</asp:ListItem>
                    <asp:ListItem>45</asp:ListItem>
                    <asp:ListItem>46</asp:ListItem>
                    <asp:ListItem>47</asp:ListItem>
                    <asp:ListItem>48</asp:ListItem>
                    <asp:ListItem>49</asp:ListItem>
                    <asp:ListItem>50</asp:ListItem>
                    <asp:ListItem>51</asp:ListItem>
                    <asp:ListItem>52</asp:ListItem>
                    <asp:ListItem>53</asp:ListItem>
                    <asp:ListItem>54</asp:ListItem>
                    <asp:ListItem>55</asp:ListItem>
                    <asp:ListItem>56</asp:ListItem>
                    <asp:ListItem>57</asp:ListItem>
                    <asp:ListItem>58</asp:ListItem>
                    <asp:ListItem>59</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td align="center" valign="middle" style="width: 250px">
            <asp:Calendar ID="CalFechaPartida" runat="server" Enabled="False" 
                        onselectionchanged="CalFechaPartida_SelectionChanged"></asp:Calendar>
                    &nbsp;</td>
            <td align="center" valign="middle" style="width: 30px">
            </td>
            <td align="left" valign="middle" style="width: 175px">
                    <asp:Label ID="LbFechaArribo" runat="server" Text="Fecha Arribo"></asp:Label>
                    <br />
                    <asp:TextBox ID="TBFechaArribo" runat="server" Enabled="False"></asp:TextBox>
                    <br />
                    <br />
                    <br />
                <asp:Label ID="LBHoraArribo" runat="server" Text="Hora Arribo"></asp:Label>
                    <br />
                <asp:DropDownList ID="DDLHoraArribo" runat="server" Enabled="False" 
                    Width="70px" onselectedindexchanged="DDLHoraArribo_SelectedIndexChanged" 
                    AutoPostBack="True">
                    <asp:ListItem>00</asp:ListItem>
                    <asp:ListItem>01</asp:ListItem>
                    <asp:ListItem>02</asp:ListItem>
                    <asp:ListItem>03</asp:ListItem>
                    <asp:ListItem>04</asp:ListItem>
                    <asp:ListItem>05</asp:ListItem>
                    <asp:ListItem>06</asp:ListItem>
                    <asp:ListItem>07</asp:ListItem>
                    <asp:ListItem>08</asp:ListItem>
                    <asp:ListItem>09</asp:ListItem>
                    <asp:ListItem>10</asp:ListItem>
                    <asp:ListItem>11</asp:ListItem>
                    <asp:ListItem>12</asp:ListItem>
                    <asp:ListItem>13</asp:ListItem>
                    <asp:ListItem>14</asp:ListItem>
                    <asp:ListItem>15</asp:ListItem>
                    <asp:ListItem>16</asp:ListItem>
                    <asp:ListItem>17</asp:ListItem>
                    <asp:ListItem>18</asp:ListItem>
                    <asp:ListItem>19</asp:ListItem>
                    <asp:ListItem>20</asp:ListItem>
                    <asp:ListItem>21</asp:ListItem>
                    <asp:ListItem>22</asp:ListItem>
                    <asp:ListItem>23</asp:ListItem>
                </asp:DropDownList>
                &nbsp;:
                <asp:DropDownList ID="DDLMinutosArribo" runat="server" Enabled="False" 
                    Width="70px" 
                    onselectedindexchanged="DDLMinutosArribo_SelectedIndexChanged" 
                    AutoPostBack="True">
                    <asp:ListItem>00</asp:ListItem>
                    <asp:ListItem>01</asp:ListItem>
                    <asp:ListItem>02</asp:ListItem>
                    <asp:ListItem>03</asp:ListItem>
                    <asp:ListItem>04</asp:ListItem>
                    <asp:ListItem>05</asp:ListItem>
                    <asp:ListItem>06</asp:ListItem>
                    <asp:ListItem>07</asp:ListItem>
                    <asp:ListItem>08</asp:ListItem>
                    <asp:ListItem>09</asp:ListItem>
                    <asp:ListItem>10</asp:ListItem>
                    <asp:ListItem>11</asp:ListItem>
                    <asp:ListItem>12</asp:ListItem>
                    <asp:ListItem>13</asp:ListItem>
                    <asp:ListItem>14</asp:ListItem>
                    <asp:ListItem>15</asp:ListItem>
                    <asp:ListItem>16</asp:ListItem>
                    <asp:ListItem>17</asp:ListItem>
                    <asp:ListItem>18</asp:ListItem>
                    <asp:ListItem>19</asp:ListItem>
                    <asp:ListItem>20</asp:ListItem>
                    <asp:ListItem>21</asp:ListItem>
                    <asp:ListItem>22</asp:ListItem>
                    <asp:ListItem>23</asp:ListItem>
                    <asp:ListItem>24</asp:ListItem>
                    <asp:ListItem>25</asp:ListItem>
                    <asp:ListItem>26</asp:ListItem>
                    <asp:ListItem>27</asp:ListItem>
                    <asp:ListItem>28</asp:ListItem>
                    <asp:ListItem>29</asp:ListItem>
                    <asp:ListItem>30</asp:ListItem>
                    <asp:ListItem>31</asp:ListItem>
                    <asp:ListItem>32</asp:ListItem>
                    <asp:ListItem>33</asp:ListItem>
                    <asp:ListItem>34</asp:ListItem>
                    <asp:ListItem>35</asp:ListItem>
                    <asp:ListItem>36</asp:ListItem>
                    <asp:ListItem>37</asp:ListItem>
                    <asp:ListItem>38</asp:ListItem>
                    <asp:ListItem>39</asp:ListItem>
                    <asp:ListItem>40</asp:ListItem>
                    <asp:ListItem>41</asp:ListItem>
                    <asp:ListItem>42</asp:ListItem>
                    <asp:ListItem>43</asp:ListItem>
                    <asp:ListItem>44</asp:ListItem>
                    <asp:ListItem>45</asp:ListItem>
                    <asp:ListItem>46</asp:ListItem>
                    <asp:ListItem>47</asp:ListItem>
                    <asp:ListItem>48</asp:ListItem>
                    <asp:ListItem>49</asp:ListItem>
                    <asp:ListItem>50</asp:ListItem>
                    <asp:ListItem>51</asp:ListItem>
                    <asp:ListItem>52</asp:ListItem>
                    <asp:ListItem>53</asp:ListItem>
                    <asp:ListItem>54</asp:ListItem>
                    <asp:ListItem>55</asp:ListItem>
                    <asp:ListItem>56</asp:ListItem>
                    <asp:ListItem>57</asp:ListItem>
                    <asp:ListItem>58</asp:ListItem>
                    <asp:ListItem>59</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td align="center" valign="middle" style="width: 250px">
                    <asp:Calendar ID="CalFechaArribo" runat="server" Enabled="False" 
                        onselectionchanged="CalFechaArribo_SelectionChanged"></asp:Calendar>
            </td>
        </tr>
        <tr>
            <td align="center" valign="middle" colspan="6">
            </td>
        </tr>
        <tr>
            <td align="left" valign="middle" style="width: 142px">
                <asp:Label ID="LBCantidadAsientos" runat="server" Text="Cantidad de Asientos: "></asp:Label>
            </td>
            <td align="left" valign="middle" colspan="5">
                <asp:TextBox ID="TBCantAsientos" runat="server" Enabled="False" Width="66px" 
                    MaxLength="3"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td align="left" valign="middle" style="width: 142px">
                <asp:Label ID="Label1" runat="server" Text="Servicio a Bordo: "></asp:Label>
            </td>
            <td align="left" valign="middle" colspan="5">
                <asp:DropDownList ID="DDLServicio" runat="server" Enabled="False">
                    <asp:ListItem>No</asp:ListItem>
                    <asp:ListItem>Si</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td align="left" valign="middle" style="width: 142px">
                <asp:Label ID="LBDocumentacion" runat="server" Text="Documentación: "></asp:Label>
            </td>
            <td align="left" valign="middle" colspan="5">
                <asp:TextBox ID="TBDocumentacion" runat="server" Enabled="False" 
                    TextMode="MultiLine" Width="257px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td align="center" valign="middle" colspan="6">
            </td>
        </tr>
        <tr>
            <td align="center" valign="middle" style="width: 142px">
                <asp:Button ID="BtnAlta" runat="server" Text="Alta" Enabled="False" onclick="BtnAlta_Click" 
                    />
            </td>
            <td align="center" valign="middle" colspan="2">
                <asp:Button ID="BtnModificar" runat="server" Text="Modificar"  Enabled="False" onclick="BtnModificar_Click" 
                    />
            </td>
            <td align="center" valign="middle" colspan="2">
                <asp:Button ID="BtnEliminar" runat="server" Text="Eliminar"  Enabled="False" onclick="BtnEliminar_Click" 
                     />
            </td>
            <td align="center" valign="middle">
                <asp:Button ID="BtnLimpiar" runat="server"
                    Text="Limpiar formulario" onclick="BtnLimpiar_Click" />
            </td>
        </tr>
    </table>
</asp:Content>

