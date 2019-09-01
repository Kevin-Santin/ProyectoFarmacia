create database farmacia;
use farmacia;

-- ============================================== --
create table tipoUsuario
(
idTipoUs int primary key,
nombreTipo Varchar(50)
);
create table usuarioSistema
(
nombre varchar(50),
contraseña varchar(50),
idTipoUs int,
constraint foreign key (idTipoUs) references tipoUsuario(idTipoUs)
);
-- ============================================== --

create table proveedor
(
idProveedor int primary key,
nombre varchar(50),
direccion varchar(80),
telefono varchar(15)
);

create table cliente
(
dui varchar(10) primary key,
nombre varchar(50)not null,
edad int not null,
telefeno varchar(9) not null,
correo varchar(60) not null
);

create table producto
(
idProducto int(11) primary key,
idProveedor int not null,
nombre varchar(50),
stock int(11),
precio double not null,
fechaFabricacion varchar(10),
fechaVencimiento varchar(10),
constraint foreign key (idProveedor) references proveedor (idProveedor)
);

create table medicamento
(
idMedicamento int(11) primary key,
idProveedor int,
nombre varchar(50),
stock int(11),
fechaFabricacion varchar(10),
fechaVencimiento varchar(10),
lote int not null,
precio double not null,
constraint foreign key (idProveedor) references proveedor (idProveedor)
);

create table grupoMedicamento
(
idGrupo int primary key,
nombreGrupo varchar(50),
descripcion varchar(50),
idMedicamento int,
constraint foreign key (idMedicamento) references medicamento(idMedicamento)
);
-- ============================================== --
create table pedidoProveedor
(
idPedidoProv int primary key,
idProveedor int not null,
fechapedido varchar(10),
constraint foreign key (idProveedor) references proveedor(idProveedor)
);

create table detallePedidoProve
(
idPedidoProv int not null,
id int not null,
cantidad int null,
descripcion varchar(100),
constraint foreign key (idPedidoProv) references pedidoProveedor(idPedidoProv),
constraint foreign key (id) references medicamento(idMedicamento),
constraint foreign key (id) references producto(idProducto)
);
-- ===============================================--
create table compraProveedor
(
idCompra int primary key,
idProveedor int not null,
fecha varchar(10) not null,
constraint foreign key (idProveedor) references proveedor(idProveedor)
);

-- ======================================================== --
create table compraCliente
(
idCompra int primary key,
duiCliente varchar(10) not null,
reservaPedido boolean default false,
fecha varchar(10) not null,
constraint foreign key (duiCliente) references cliente(dui)
);

create table detalleCompraCliente
(
idCompra int not null,
id int,
cantidad int null,
descripcionPedido varchar(100),
constraint foreign key (id) references medicamento(idMedicamento),
constraint foreign key (idCompra) references compraCliente(idCompra),
constraint foreign key (id) references producto(idProducto)
);

create table facturaCliente(
idFactura int auto_increment primary key,
fecha varchar(10) not null,
total double not null
);

create table detalleFacturaCliente(
idFactura int not null,
idCompraCliente int not null,
descripcion varchar(50) not null,
subtotal double not null,
constraint foreign key(idFactura) references facturaCliente(idFactura),
constraint foreign key(idCompraCliente) references compraCliente(idCompra)
);

create table DCProveedorMedicamentos
(
idCompra int not null,
idMedicamento int not null,
cantidad int null,
descripcion varchar(100),
constraint foreign key (idCompra) references compraProveedor(idCompra),
constraint foreign key (idMedicamento) references medicamento(idMedicamento)
);

create table DCProveedorProductos
(
idCompra int not null,
idProducto int not null,
cantidad int null,
descripcion varchar(100),
constraint foreign key (idCompra) references compraProveedor(idCompra),
constraint foreign key (idProducto) references producto(idProducto)
);