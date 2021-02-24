-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-02-21 17:31:55.993

-- tables
-- Table: Activador
CREATE TABLE Activador (
    CRol int  NOT NULL,
    CActivador int  NOT NULL,
    CONSTRAINT Activador_pk PRIMARY KEY  (CActivador)
);

-- Table: Campania
CREATE TABLE Campania (
    CCampania int  NOT NULL,
    MInvertido money  NOT NULL,
    DInicio date  NOT NULL,
    DFinal date  NOT NULL,
    numAlcance int  NOT NULL,
    NCampania varchar(30)  NOT NULL,
    CONSTRAINT Campania_pk PRIMARY KEY  (CCampania)
);

-- Table: Categoria
CREATE TABLE Categoria (
    CCategoria int  NOT NULL,
    NCategoria varchar(30)  NOT NULL,
    CONSTRAINT Categoria_pk PRIMARY KEY  (CCategoria)
);

-- Table: Compra_Proveedor
CREATE TABLE Compra_Proveedor (
    CProveedor int  NOT NULL,
    CSede int  NOT NULL,
    CCompra int  NOT NULL,
    DCompra date  NOT NULL,
    MTotal money  NOT NULL,
    CONSTRAINT Compra_Proveedor_pk PRIMARY KEY  (CCompra)
);

-- Table: Departamento
CREATE TABLE Departamento (
    CDepartamento int  NOT NULL,
    NDepartamento varchar(30)  NOT NULL,
    CONSTRAINT Departamento_pk PRIMARY KEY  (CDepartamento)
);

-- Table: Detalle_Compra
CREATE TABLE Detalle_Compra (
    CProducto int  NOT NULL,
    CCompra int  NOT NULL,
    QProducto int  NOT NULL,
    MParcial money  NOT NULL,
    CONSTRAINT Detalle_Compra_pk PRIMARY KEY  (CProducto,CCompra)
);

-- Table: Dia
CREATE TABLE Dia (
    CDia int  NOT NULL,
    NDia varchar(30)  NOT NULL,
    CONSTRAINT Dia_pk PRIMARY KEY  (CDia)
);

-- Table: Distrito
CREATE TABLE Distrito (
    CDistrito int  NOT NULL,
    NDistrito varchar(30)  NOT NULL,
    CProvincia int  NOT NULL,
    CONSTRAINT Distrito_pk PRIMARY KEY  (CDistrito)
);

-- Table: Empleado
CREATE TABLE Empleado (
    DIncioContrato date  NOT NULL,
    DFinalContrato date  NOT NULL,
    TCorreoLaboral text  NOT NULL,
    CSede int  NOT NULL,
    CTurno int  NOT NULL,
    CPuesto int  NOT NULL,
    CEmpleado int  NOT NULL,
    CJefe int  NULL,
    CONSTRAINT Empleado_pk PRIMARY KEY  (CEmpleado)
);

-- Table: Horario_Sede
CREATE TABLE Horario_Sede (
    CSede int  NOT NULL,
    CDia int  NOT NULL,
    DApertura time(2)  NOT NULL,
    DCierre time(2)  NOT NULL,
    CONSTRAINT Horario_Sede_pk PRIMARY KEY  (CDia,CSede)
);

-- Table: Inscripcion
CREATE TABLE Inscripcion (
    CInscripcion int  NOT NULL,
    CPlan int  NOT NULL,
    CSede int  NOT NULL,
    DIncripcion date  NOT NULL,
    FCampania binary(1)  NOT NULL,
    CMetodoPago int  NOT NULL,
    CEmpleado int  NULL,
    CUsuario int  NOT NULL,
    CONSTRAINT Inscripcion_pk PRIMARY KEY  (CInscripcion,DIncripcion)
);

-- Table: Marca
CREATE TABLE Marca (
    CMarca int  NOT NULL,
    NMarca varchar(30)  NOT NULL,
    CONSTRAINT Marca_pk PRIMARY KEY  (CMarca)
);

-- Table: MarcaVehiculo
CREATE TABLE MarcaVehiculo (
    CMarcaVehiculo int  NOT NULL,
    NMarcaVehiculo varchar(30)  NOT NULL,
    CONSTRAINT MarcaVehiculo_pk PRIMARY KEY  (CMarcaVehiculo)
);

-- Table: Metodo_Pago
CREATE TABLE Metodo_Pago (
    CMetodoPago int  NOT NULL,
    NFormaPago varchar(30)  NOT NULL,
    CONSTRAINT Metodo_Pago_pk PRIMARY KEY  (CMetodoPago)
);

-- Table: Modelo
CREATE TABLE Modelo (
    CModelo int  NOT NULL,
    NModelo varchar(30)  NOT NULL,
    CMarca int  NOT NULL,
    CONSTRAINT Modelo_pk PRIMARY KEY  (CModelo)
);

-- Table: ObjeticoFit
CREATE TABLE ObjeticoFit (
    CObjetivoFit int  NOT NULL,
    NObjetivoUsuario varchar(30)  NOT NULL,
    CONSTRAINT ObjeticoFit_pk PRIMARY KEY  (CObjetivoFit)
);

-- Table: Persona
CREATE TABLE Persona (
    NPersona nvarchar(30)  NOT NULL,
    DFechaNacimiento date  NOT NULL,
    NumTelefono int  NOT NULL,
    TAvenida text  NOT NULL,
    NumLote int  NOT NULL,
    NumMz int  NOT NULL,
    TCorreoElectronico nvarchar(100),
    NApellidoPaterno nvarchar(30)  NOT NULL,
    NApellidoMaterno nvarchar(30)  NOT NULL,
    CTipoDocumento int  NOT NULL,
    CPersona int  NOT NULL,
    CONSTRAINT Persona_pk PRIMARY KEY  (CPersona)
);

-- Table: Plan
CREATE TABLE "Plan" (
    CPlan int  NOT NULL,
    NPlan varchar(30)  NOT NULL,
    FIncluyePolo binary(1)  NOT NULL,
    Fcancelacion binary(1)  NOT NULL,
    MmantenimientoAnual money  NOT NULL,
    FIncluyeInvitados binary(1)  NOT NULL,
    CONSTRAINT Plan_pk PRIMARY KEY  (CPlan)
);

-- Table: PlanCampania
CREATE TABLE PlanCampania (
    CCampania int  NOT NULL,
    CPlan int  NOT NULL,
    CONSTRAINT PlanCampania_pk PRIMARY KEY  (CCampania,CPlan)
);

-- Table: PlanSede
CREATE TABLE PlanSede (
    CPlan int  NOT NULL,
    CSede int  NOT NULL,
    MPrecio money  NOT NULL,
    CONSTRAINT PlanSede_pk PRIMARY KEY  (CPlan,CSede)
);

-- Table: Plataforma
CREATE TABLE Plataforma (
    CPlataforma int  NOT NULL,
    NPlataforma varchar(30)  NOT NULL,
    CONSTRAINT Plataforma_pk PRIMARY KEY  (CPlataforma)
);

-- Table: PresencialCamp
CREATE TABLE PresencialCamp (
    CPresencialCamp int  NOT NULL,
    CZona int  NOT NULL,
    CActivador int  NOT NULL,
    CONSTRAINT PresencialCamp_pk PRIMARY KEY  (CPresencialCamp,CZona)
);

-- Table: Producto
CREATE TABLE Producto (
    CProducto int  NOT NULL,
    NProducto varchar(30)  NOT NULL,
    MPrecio money  NOT NULL,
    CModelo int  NOT NULL,
    CSubCategoria int  NOT NULL,
    stock int NOT NULL,
    CONSTRAINT Producto_pk PRIMARY KEY  (CProducto)
);

-- Table: ProductoVenta
CREATE TABLE ProductoVenta (
    CProducto int  NOT NULL,
    CVenta int  NOT NULL,
    MParcial money  NOT NULL,
	QProducto int  NOT NULL,
    CONSTRAINT ProductoVenta_pk PRIMARY KEY  (CProducto,CVenta)
);

-- Table: Proveedor
CREATE TABLE Proveedor (
    CProveedor int  NOT NULL,
    NProveedor varchar(30)  NOT NULL,
    NumbProveedor int  NOT NULL,
    CONSTRAINT Proveedor_pk PRIMARY KEY  (CProveedor)
);

-- Table: Provincia
CREATE TABLE Provincia (
    CProvincia int  NOT NULL,
    NProvincia varchar(30)  NOT NULL,
    CDepartamento int  NOT NULL,
    CONSTRAINT Provincia_pk PRIMARY KEY  (CProvincia)
);

-- Table: PuestoTrabajo
CREATE TABLE PuestoTrabajo (
    CPuesto int  NOT NULL,
    NPuesto varchar(30)  NOT NULL,
    CONSTRAINT PuestoTrabajo_pk PRIMARY KEY  (CPuesto)
);

-- Table: RegistroInvitado
CREATE TABLE RegistroInvitado (
    CReservaHorario int  NOT NULL,
    CInvitado int  NOT NULL,
    CONSTRAINT RegistroInvitado_pk PRIMARY KEY  (CReservaHorario,CInvitado)
);

-- Table: Repartidor
CREATE TABLE Repartidor (
    CVehiculo int  NOT NULL,
    CRepartidor int  NOT NULL,
    CONSTRAINT Repartidor_pk PRIMARY KEY  (CRepartidor)
);

-- Table: ReservaHorario
CREATE TABLE ReservaHorario (
    CSede int  NOT NULL,
    CReservaHorario int  NOT NULL,
    FDisponible binary(1)  NOT NULL,
    DRegistro smalldatetime  NOT NULL,
    FReservaActiva binary(1)  NOT NULL,
    CUsuario int  NOT NULL,
    CONSTRAINT ReservaHorario_pk PRIMARY KEY  (CReservaHorario)
);

-- Table: Rol
CREATE TABLE Rol (
    CRol int  NOT NULL,
    NRol varchar(30)  NOT NULL,
    CONSTRAINT Rol_pk PRIMARY KEY  (CRol)
);

-- Table: RutaRepartidor
CREATE TABLE RutaRepartidor (
    CZona int  NOT NULL,
    CRepartidor int  NOT NULL,
    CONSTRAINT RutaRepartidor_pk PRIMARY KEY  (CZona,CRepartidor)
);

-- Table: Sede
CREATE TABLE Sede (
    CSede int  NOT NULL,
    NSede varchar(30)  NOT NULL,
    Distrito_CDistrito int  NOT NULL,
    QAforo int NOT NULL,
    CONSTRAINT Sede_pk PRIMARY KEY  (CSede)
);

-- Table: SubCategoria
CREATE TABLE SubCategoria (
    CSubCategoria int  NOT NULL,
    NSubCategoria varchar(30)  NOT NULL,
    CCategoria int  NOT NULL,
    CONSTRAINT SubCategoria_pk PRIMARY KEY  (CSubCategoria)
);

-- Table: TipoPublicidad
CREATE TABLE TipoPublicidad (
    CTipo int  NOT NULL,
    NTipo varchar(30)  NOT NULL,
    CONSTRAINT TipoPublicidad_pk PRIMARY KEY  (CTipo)
);

-- Table: Tipo_Documento
CREATE TABLE Tipo_Documento (
    CTipoDocumento int  NOT NULL,
    NTipoDocumento varchar(30)  NOT NULL,
    CONSTRAINT Tipo_Documento_pk PRIMARY KEY  (CTipoDocumento)
);

-- Table: TurnoTrabajo
CREATE TABLE TurnoTrabajo (
    CTurno int  NOT NULL,
    NTurno varchar(30)  NOT NULL,
    DIncio time(2)  NOT NULL,
    DFinal time(2)  NOT NULL,
    CONSTRAINT TurnoTrabajo_pk PRIMARY KEY  (CTurno)
);

-- Table: Usuario
CREATE TABLE Usuario (
    CObjetivoFit int  NOT NULL,
    CUsuario int  NOT NULL,
    CONSTRAINT Usuario_pk PRIMARY KEY  (CUsuario)
);

-- Table: Vehiculo
CREATE TABLE Vehiculo (
    CVehiculo int  NOT NULL,
    NColorVehiculo varchar(30)  NOT NULL,
    CMarcaVehiculo int  NOT NULL,
    CONSTRAINT Vehiculo_pk PRIMARY KEY  (CVehiculo)
);

-- Table: Venta
CREATE TABLE Venta (
    CVenta int  NOT NULL,
    CPersona int  NOT NULL,
    MTotal money  NOT NULL,
    CMetodoPago int  NOT NULL,
    DVenta date  NOT NULL,
    CONSTRAINT Venta_pk PRIMARY KEY  (CVenta)
);

-- Table: VentaPresencial
CREATE TABLE VentaPresencial (
    CVentaPresencial int  NOT NULL,
    CSede int  NOT NULL,
    CEmpleado int  NOT NULL,
    CONSTRAINT VentaPresencial_pk PRIMARY KEY  (CVentaPresencial)
);

-- Table: VentaVirtual
CREATE TABLE VentaVirtual (
    CVentaVirtual int  NOT NULL,
    CDistrito int  NOT NULL,
    NVia varchar(30)  NOT NULL,
    NumVivienda int  NOT NULL,
    CRepartridor int  NOT NULL,
    CONSTRAINT VentaVirtual_pk PRIMARY KEY  (CVentaVirtual)
);

-- Table: VirtualCamp
CREATE TABLE VirtualCamp (
    CVirtualCamp int  NOT NULL,
    CTipo int  NOT NULL,
    CONSTRAINT VirtualCamp_pk PRIMARY KEY  (CVirtualCamp)
);

-- Table: VirtualPlataforma
CREATE TABLE VirtualPlataforma (
    CVirtualCamp int  NOT NULL,
    CPlataforma int  NOT NULL,
    CONSTRAINT VirtualPlataforma_pk PRIMARY KEY  (CPlataforma,CVirtualCamp)
);

-- Table: Zona
CREATE TABLE Zona (
    CZona int  NOT NULL,
    NZona varchar(30)  NOT NULL,
    CONSTRAINT Zona_pk PRIMARY KEY  (CZona)
);

-- Table: ZonaRepartidor
CREATE TABLE ZonaRepartidor (
    CZona int  NOT NULL,
    NZona varchar(30)  NOT NULL,
    NumLatitudInicio int  NOT NULL,
    NumLongitudFin int  NOT NULL,
    NumLatitudFin int  NOT NULL,
    NumLongitudInicio int  NOT NULL,
    CONSTRAINT ZonaRepartidor_pk PRIMARY KEY  (CZona)
);

-- foreign keys
-- Reference: Activador_Persona (table: Activador)
ALTER TABLE Activador ADD CONSTRAINT Activador_Persona
    FOREIGN KEY (CActivador)
    REFERENCES Persona (CPersona);

-- Reference: Activadores_ROL (table: Activador)
ALTER TABLE Activador ADD CONSTRAINT Activadores_ROL
    FOREIGN KEY (CRol)
    REFERENCES Rol (CRol);

-- Reference: Distrito_Provincia (table: Distrito)
ALTER TABLE Distrito ADD CONSTRAINT Distrito_Provincia
    FOREIGN KEY (CProvincia)
    REFERENCES Provincia (CProvincia);

-- Reference: Empleado_Empleado (table: Empleado)
ALTER TABLE Empleado ADD CONSTRAINT Empleado_Empleado
    FOREIGN KEY (CJefe)
    REFERENCES Empleado (CEmpleado);

-- Reference: Empleado_Persona (table: Empleado)
ALTER TABLE Empleado ADD CONSTRAINT Empleado_Persona
    FOREIGN KEY (CEmpleado)
    REFERENCES Persona (CPersona);

-- Reference: Empleado_PuestoTrabajo (table: Empleado)
ALTER TABLE Empleado ADD CONSTRAINT Empleado_PuestoTrabajo
    FOREIGN KEY (CPuesto)
    REFERENCES PuestoTrabajo (CPuesto);

-- Reference: Empleado_Sede (table: Empleado)
ALTER TABLE Empleado ADD CONSTRAINT Empleado_Sede
    FOREIGN KEY (CSede)
    REFERENCES Sede (CSede);

-- Reference: Empleado_TurnoTrabajo (table: Empleado)
ALTER TABLE Empleado ADD CONSTRAINT Empleado_TurnoTrabajo
    FOREIGN KEY (CTurno)
    REFERENCES TurnoTrabajo (CTurno);

-- Reference: Horario_Sede_Dia (table: Horario_Sede)
ALTER TABLE Horario_Sede ADD CONSTRAINT Horario_Sede_Dia
    FOREIGN KEY (CDia)
    REFERENCES Dia (CDia);

-- Reference: Horario_Sede_Sede (table: Horario_Sede)
ALTER TABLE Horario_Sede ADD CONSTRAINT Horario_Sede_Sede
    FOREIGN KEY (CSede)
    REFERENCES Sede (CSede);

-- Reference: Inscripcion_Empleado (table: Inscripcion)
ALTER TABLE Inscripcion ADD CONSTRAINT Inscripcion_Empleado
    FOREIGN KEY (CEmpleado)
    REFERENCES Empleado (CEmpleado);

-- Reference: Inscripcion_Metodo_Pago (table: Inscripcion)
ALTER TABLE Inscripcion ADD CONSTRAINT Inscripcion_Metodo_Pago
    FOREIGN KEY (CMetodoPago)
    REFERENCES Metodo_Pago (CMetodoPago);

-- Reference: Inscripcion_Usuario (table: Inscripcion)
ALTER TABLE Inscripcion ADD CONSTRAINT Inscripcion_Usuario
    FOREIGN KEY (CUsuario)
    REFERENCES Usuario (CUsuario);

-- Reference: Invitados_ReservaHorario (table: RegistroInvitado)
ALTER TABLE RegistroInvitado ADD CONSTRAINT Invitados_ReservaHorario
    FOREIGN KEY (CReservaHorario)
    REFERENCES ReservaHorario (CReservaHorario);

-- Reference: Modelo_Marca (table: Modelo)
ALTER TABLE Modelo ADD CONSTRAINT Modelo_Marca
    FOREIGN KEY (CMarca)
    REFERENCES Marca (CMarca);

-- Reference: Persona_Tipo_Documento (table: Persona)
ALTER TABLE Persona ADD CONSTRAINT Persona_Tipo_Documento
    FOREIGN KEY (CTipoDocumento)
    REFERENCES Tipo_Documento (CTipoDocumento);

-- Reference: PlanCampania_CPlanes (table: PlanCampania)
ALTER TABLE PlanCampania ADD CONSTRAINT PlanCampania_CPlanes
    FOREIGN KEY (CPlan)
    REFERENCES "Plan" (CPlan);

-- Reference: PlanSede_CPlanes (table: PlanSede)
ALTER TABLE PlanSede ADD CONSTRAINT PlanSede_CPlanes
    FOREIGN KEY (CPlan)
    REFERENCES "Plan" (CPlan);

-- Reference: PlanSede_Sede (table: PlanSede)
ALTER TABLE PlanSede ADD CONSTRAINT PlanSede_Sede
    FOREIGN KEY (CSede)
    REFERENCES Sede (CSede);

-- Reference: PresencialCamp_Activador (table: PresencialCamp)
ALTER TABLE PresencialCamp ADD CONSTRAINT PresencialCamp_Activador
    FOREIGN KEY (CActivador)
    REFERENCES Activador (CActivador);

-- Reference: PresencialCamp_Zona (table: PresencialCamp)
ALTER TABLE PresencialCamp ADD CONSTRAINT PresencialCamp_Zona
    FOREIGN KEY (CZona)
    REFERENCES Zona (CZona);

-- Reference: ProductoVenta_Producto (table: ProductoVenta)
ALTER TABLE ProductoVenta ADD CONSTRAINT ProductoVenta_Producto
    FOREIGN KEY (CProducto)
    REFERENCES Producto (CProducto);

-- Reference: ProductoVenta_Venta (table: ProductoVenta)
ALTER TABLE ProductoVenta ADD CONSTRAINT ProductoVenta_Venta
    FOREIGN KEY (CVenta)
    REFERENCES Venta (CVenta);

-- Reference: Producto_Modelo (table: Producto)
ALTER TABLE Producto ADD CONSTRAINT Producto_Modelo
    FOREIGN KEY (CModelo)
    REFERENCES Modelo (CModelo);

-- Reference: Producto_SubCategoria (table: Producto)
ALTER TABLE Producto ADD CONSTRAINT Producto_SubCategoria
    FOREIGN KEY (CSubCategoria)
    REFERENCES SubCategoria (CSubCategoria);

-- Reference: Provincia_Departamento (table: Provincia)
ALTER TABLE Provincia ADD CONSTRAINT Provincia_Departamento
    FOREIGN KEY (CDepartamento)
    REFERENCES Departamento (CDepartamento);

-- Reference: RegistroInvitado_Persona (table: RegistroInvitado)
ALTER TABLE RegistroInvitado ADD CONSTRAINT RegistroInvitado_Persona
    FOREIGN KEY (CInvitado)
    REFERENCES Persona (CPersona);

-- Reference: Registro_Inscripcion_PlanSede (table: Inscripcion)
ALTER TABLE Inscripcion ADD CONSTRAINT Registro_Inscripcion_PlanSede
    FOREIGN KEY (CPlan,CSede)
    REFERENCES PlanSede (CPlan,CSede);

-- Reference: Repartidor_Persona (table: Repartidor)
ALTER TABLE Repartidor ADD CONSTRAINT Repartidor_Persona
    FOREIGN KEY (CRepartidor)
    REFERENCES Persona (CPersona);

-- Reference: Repartidor_Vehiculo (table: Repartidor)
ALTER TABLE Repartidor ADD CONSTRAINT Repartidor_Vehiculo
    FOREIGN KEY (CVehiculo)
    REFERENCES Vehiculo (CVehiculo);

-- Reference: ReservaHorario_Usuario (table: ReservaHorario)
ALTER TABLE ReservaHorario ADD CONSTRAINT ReservaHorario_Usuario
    FOREIGN KEY (CUsuario)
    REFERENCES Usuario (CUsuario);

-- Reference: RutaRepartidor_Repartidor (table: RutaRepartidor)
ALTER TABLE RutaRepartidor ADD CONSTRAINT RutaRepartidor_Repartidor
    FOREIGN KEY (CRepartidor)
    REFERENCES Repartidor (CRepartidor);

-- Reference: RutaRepartidor_ZonaRepartidor (table: RutaRepartidor)
ALTER TABLE RutaRepartidor ADD CONSTRAINT RutaRepartidor_ZonaRepartidor
    FOREIGN KEY (CZona)
    REFERENCES ZonaRepartidor (CZona);

-- Reference: Sede_Distrito (table: Sede)
ALTER TABLE Sede ADD CONSTRAINT Sede_Distrito
    FOREIGN KEY (Distrito_CDistrito)
    REFERENCES Distrito (CDistrito);

-- Reference: SubCategoria_Categoria (table: SubCategoria)
ALTER TABLE SubCategoria ADD CONSTRAINT SubCategoria_Categoria
    FOREIGN KEY (CCategoria)
    REFERENCES Categoria (CCategoria);

-- Reference: Table_13_Campania (table: PlanCampania)
ALTER TABLE PlanCampania ADD CONSTRAINT Table_13_Campania
    FOREIGN KEY (CCampania)
    REFERENCES Campania (CCampania);

-- Reference: Table_44_Proveedor (table: Compra_Proveedor)
ALTER TABLE Compra_Proveedor ADD CONSTRAINT Table_44_Proveedor
    FOREIGN KEY (CProveedor)
    REFERENCES Proveedor (CProveedor);

-- Reference: Table_44_Sede (table: Compra_Proveedor)
ALTER TABLE Compra_Proveedor ADD CONSTRAINT Table_44_Sede
    FOREIGN KEY (CSede)
    REFERENCES Sede (CSede);

-- Reference: Table_45_Pedido_Proveedor (table: Detalle_Compra)
ALTER TABLE Detalle_Compra ADD CONSTRAINT Table_45_Pedido_Proveedor
    FOREIGN KEY (CCompra)
    REFERENCES Compra_Proveedor (CCompra);

-- Reference: Table_45_Producto (table: Detalle_Compra)
ALTER TABLE Detalle_Compra ADD CONSTRAINT Table_45_Producto
    FOREIGN KEY (CProducto)
    REFERENCES Producto (CProducto);

-- Reference: Table_8_Campania (table: PresencialCamp)
ALTER TABLE PresencialCamp ADD CONSTRAINT Table_8_Campania
    FOREIGN KEY (CPresencialCamp)
    REFERENCES Campania (CCampania);

-- Reference: Table_9_Campania (table: VirtualCamp)
ALTER TABLE VirtualCamp ADD CONSTRAINT Table_9_Campania
    FOREIGN KEY (CVirtualCamp)
    REFERENCES Campania (CCampania);

-- Reference: UsuarioHorario_Sede (table: ReservaHorario)
ALTER TABLE ReservaHorario ADD CONSTRAINT UsuarioHorario_Sede
    FOREIGN KEY (CSede)
    REFERENCES Sede (CSede);

-- Reference: Usuario_ObjeticoFit (table: Usuario)
ALTER TABLE Usuario ADD CONSTRAINT Usuario_ObjeticoFit
    FOREIGN KEY (CObjetivoFit)
    REFERENCES ObjeticoFit (CObjetivoFit);

-- Reference: Usuario_Persona (table: Usuario)
ALTER TABLE Usuario ADD CONSTRAINT Usuario_Persona
    FOREIGN KEY (CUsuario)
    REFERENCES Persona (CPersona);

-- Reference: Vehiculo_Marca (table: Vehiculo)
ALTER TABLE Vehiculo ADD CONSTRAINT Vehiculo_Marca
    FOREIGN KEY (CMarcaVehiculo)
    REFERENCES MarcaVehiculo (CMarcaVehiculo);

-- Reference: VentaPresencial_Empleado (table: VentaPresencial)
ALTER TABLE VentaPresencial ADD CONSTRAINT VentaPresencial_Empleado
    FOREIGN KEY (CEmpleado)
    REFERENCES Empleado (CEmpleado);

-- Reference: VentaPresencial_Sede (table: VentaPresencial)
ALTER TABLE VentaPresencial ADD CONSTRAINT VentaPresencial_Sede
    FOREIGN KEY (CSede)
    REFERENCES Sede (CSede);

-- Reference: VentaPresencial_Venta (table: VentaPresencial)
ALTER TABLE VentaPresencial ADD CONSTRAINT VentaPresencial_Venta
    FOREIGN KEY (CVentaPresencial)
    REFERENCES Venta (CVenta);

-- Reference: VentaVirtual_Distrito (table: VentaVirtual)
ALTER TABLE VentaVirtual ADD CONSTRAINT VentaVirtual_Distrito
    FOREIGN KEY (CDistrito)
    REFERENCES Distrito (CDistrito);

-- Reference: VentaVirtual_Repartidor (table: VentaVirtual)
ALTER TABLE VentaVirtual ADD CONSTRAINT VentaVirtual_Repartidor
    FOREIGN KEY (CRepartridor)
    REFERENCES Repartidor (CRepartidor);

-- Reference: VentaVirtual_Venta (table: VentaVirtual)
ALTER TABLE VentaVirtual ADD CONSTRAINT VentaVirtual_Venta
    FOREIGN KEY (CVentaVirtual)
    REFERENCES Venta (CVenta);

-- Reference: Venta_Metodo_Pago (table: Venta)
ALTER TABLE Venta ADD CONSTRAINT Venta_Metodo_Pago
    FOREIGN KEY (CMetodoPago)
    REFERENCES Metodo_Pago (CMetodoPago);

-- Reference: Venta_Persona (table: Venta)
ALTER TABLE Venta ADD CONSTRAINT Venta_Persona
    FOREIGN KEY (CPersona)
    REFERENCES Persona (CPersona);

-- Reference: VirtualCamp_TipoPublicidad (table: VirtualCamp)
ALTER TABLE VirtualCamp ADD CONSTRAINT VirtualCamp_TipoPublicidad
    FOREIGN KEY (CTipo)
    REFERENCES TipoPublicidad (CTipo);

-- Reference: VirtualPlataforma_Plataforma (table: VirtualPlataforma)
ALTER TABLE VirtualPlataforma ADD CONSTRAINT VirtualPlataforma_Plataforma
    FOREIGN KEY (CPlataforma)
    REFERENCES Plataforma (CPlataforma);

-- Reference: VirtualPlataforma_VirtualCamp (table: VirtualPlataforma)
ALTER TABLE VirtualPlataforma ADD CONSTRAINT VirtualPlataforma_VirtualCamp
    FOREIGN KEY (CVirtualCamp)
    REFERENCES VirtualCamp (CVirtualCamp);

-- End of file.

