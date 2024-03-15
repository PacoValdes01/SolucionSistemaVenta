Use DBVENTA

Select * from dbo.Configuracion
Select * from dbo.Categoria
Select * from dbo.DetalleVenta
Select * from dbo.Menu
Select * from dbo.Negocio
Select * from dbo.NumeroCorrelativo
Select * from dbo.Producto
Select * from dbo.Rol
Select * from dbo.RolMenu
Select * from dbo.TipoDocumentoVenta
Select * from dbo.Usuario
Select * from dbo.Venta

EXEC sp_rename 'Negocio.numeroDocumento', 'RFC';
EXEC sp_rename 'Negocio.Razon Social', 'RazonSocial';

Select * from dbo.Negocio
ALTER TABLE dbo.Negocio DROP COLUMN porcentajeImpuesto;

ALTER TABLE dbo.Negocio
ADD CodigoPostal varchar(6) null;

ALTER TABLE dbo.Negocio
ADD RegimenFiscal varchar (10) null,
 RazonSocial varchar (100)null;
 ALTER TABLE dbo.Negocio ADD RazonSocial varchar (100) null;

select * from dbo.Negocio;
update dbo.Negocio set RFC = 'XXXXXXXXXXXXX' where idNegocio= 1;

ALTER TABLE dbo.Negocio DROP COLUMN CodigoPostal;
ALTER TABLE dbo.Negocio DROP COLUMN RégimenFiscal;
ALTER TABLE dbo.Negocio DROP COLUMN Razónsocial;

Select * from dbo.MedidaLocal
Select * from dbo.MedidaSAT
Select * from dbo.RegimenFiscal
Select * from dbo.ClaveProducto
Select * from dbo.ObjImpuesto
Select * from dbo.ImpuestoSAT

create table dbo.MedidaLocal (
	clave_medida varchar (8) PRIMARY KEY NOT NULL , 
	descripcion varchar (50)NOT NULL
)

INSERT INTO dbo.MedidaLocal 
	values ('PZA','Pieza'),
			('CJA','Caja'),
			('KG','Kilo gramo'),
			('L','Litros'),
			('Cm','Centimetros'),
			('Km','Kilometros'),
			('G','Gramos'),
			('Mts','Metros');


CREATE TABLE dbo.MedidaSAT (
	C_ClaveUnidad_SAT varchar (6) PRIMARY KEY NOT NULL, 
	nombre varchar (80) NOT NULL,
	descripcion varchar (80) NOT NULL
)

INSERT INTO dbo.MedidaSAT
	values ('H87','Pieza','Múltiplos/ Fracciones/ Decimales'),
			('EA','Elemento','Unidades de venta'),
			('E48','Unidad de Servicio','Unidades especificas de la industria (varias)'),
			('ACT','Actividad','Unidades de venta'),
			('KGM','Kilogramo','Mecánica'),
			('E51','Trabajo','Unidades específicas de la industria (varias)'),
			('A9','Tarifa','Diversos'),
			('MTR','Metro','Tiempo y Espacio'),
			('AB','Paquete a granel','Diversos'),
			('BB','Caja base','Unidades específicas de la industria (varias)'),
			('KT','Kit','Unidades de venta'),
			('SET','Conjunto','Unidades de venta'),
			('LTR','Litro','Tiempo y espacio'),
			('XBX','Caja','Unidades de empaque'),
			('MON','Mes','Tiempo y espacio'),
			('HUR','Hora','Tiempo y espacio'),
			('MTK','Metro cuadrado','Tiempo y espacio'),
			('11','Equipos','Diversos'),
			('MGM','Miligramo','Mecánica'),
			('XPK','Paquete','Unidades de empaque'),
			('XKI','Kit (Conjunto de piezas)','Unidades de empaque'),
			('AS','Variedad','Diversos'),
			('GRM','Gramo','Mecánica'),
			('PR','Par','Números enteros/ Números/ Ratios'),
			('DCP','Docenas de piezas','Unidades de venta'),
			('XUN','Unidad','Unidades de empaque'),
			('XLT','Lote','Unidades de empaque'),
			('10','Grupos','Diversos'),
			('MLT','Mililitro','Tiempo y espacio'),
			('E54','Viaje','Unidades especificas de la industria');


CREATE TABLE dbo.RegimenFiscal (
	c_RegimenFiscal smallint NOT NULL primary key,
	descripcion varchar (100) not null, 
	fisica varchar (2) not null,
	moral varchar (2) not null
)

INSERT INTO dbo.RegimenFiscal
	values ('601','General de Ley Personas Morales','NO','SI'),
			('603','Personas Morales Con Fines no Lucrativos','NO','SI'),
			('605','Sueldos y Salarios e Ingresos Asimilados a Salarios','SI','NO'),
			('606','Arrendamiento','SI','NO'),
			('607','Régimen de Enajenación o Adquisición de Bienes','SI','NO'),
			('608','Demás ingresos','SI','NO'),
			('609','Consolidación','SI','NO'),
			('610','Residentes en el Extranjero sin Establecimiento Permanente en México','SI','SI'),
			('611','Ingresos por Dividendos (socios y accionistas)','SI','NO'),
			('612','Personas Físicas con Actividades Empresariales y Profesionales','SI','NO'),
			('614','Ingresos por intereses','SI','NO'),
			('615','Régimen de los ingresos por obtención de premios','SI','NO'),
			('616','Sin obligaciones fiscales','SI','NO'),
			('620','Sociedades Cooperativas de Producción que optan por diferir sus ingresos','NO','SI'),
			('621','Incorporación Fiscal','SI','NO'),
			('622','Actividades Agrícolas, Ganaderas, Silvícolas y Pesqueras','NO','SI'),
			('623','Opcional para Grupos de Sociedades','NO','SI'),
			('624','Coordinados','NO','SI'),
			('625','Régimen de las Actividades Empresariales con ingresos a través de Plataformas Tecnológicas','SI','NO'),
			('626','Régimen simplificado de Confianza','SI','SI'),
			('628','Hidrocarburos','NO','SI'),
			('629','De los Regímenes Fiscales Preferentes y de las Empresas Multinacionales','SI','NO'),
			('630','Enajenación de acciones en bolsa de valores','SI','NO');

CREATE TABLE dbo.ClaveProducto (
	c_ClaveProdServ int not null primary key, 
	descripcion varchar (80) not null,
	IVATraslado varchar (50) not null,
	IPESTraslado varchar (50) not null,
)

INSERT INTO dbo.claveProducto
	Values ('43211701', 'Equipo de lectura de código de barras', 'Opcional', 'Opcional'),
			('43211702', 'Lectores y codificadores de banda magnética', 'Opcional', 'Opcional'),
			('43211706', 'Teclados', 'Opcional', 'Opcional'),
			('43211708', 'Mouse o bola de seguimiento para computador', 'Opcional', 'Opcional'),
			('43211719', 'Micrófonos de voz para computadores', 'Opcional', 'Opcional'),
			('43211720', 'Terminales de pago para puntos de venta', 'Opcional', 'Opcional'),
			('43211806', 'Descansa muñecas para teclado', 'Opcional', 'Opcional'),
			('43211807', 'Descansa muñecas para mouse', 'Opcional', 'Opcional'),
			('43211902', 'Paneles o monitores de pantalla de cristal líquido lcd', 'Opcional', 'Opcional'),
			('43211903', 'Monitores de pantalla táctil (touch)', 'Opcional', 'Opcional'),
			('43211911', 'Vidrio de pantalla táctil (touch)', 'Opcional', 'Opcional'),
			('43211912', 'Película de pantalla táctil (touch)', 'Opcional', 'Opcional'),
			('43211907', 'Cascos de realidad virtual', 'Opcional', 'Opcional'),
			('43211501', 'Servidores de computador (Servidores de computadoras)', 'Opcional', 'Opcional');


CREATE TABLE dbo.ObjImpuesto (
	c_ObjetoImp tinyint not null primary key,
	descripcion varchar (80) not null
)

INSERT INTO dbo.ObjImpuesto 
	Values ('01','No objeto de impuesto'),
			('02','Si objeto de impuesto'),
			('03','Si objeto del impuesto y no obligado al desglose'),
			('04','Si objeto del impuesto y no causa impuesto'),
			('05','Si objeto del impuesto, IVA crédito PODEBI');

CREATE TABLE dbo.ImpuestoSAT (
	c_impuesto tinyint not null primary key,
	descripcion varchar (80) not null,
	retencion varchar (2) not null,
	traslado varchar (2) not null,
	LocFederal varchar (10) not null
)

INSERT INTO dbo.ImpuestoSAT
	Values ('001', 'ISR', 'SI', 'NO', 'Federal'),
			('002', 'IVA', 'SI', 'SI', 'Federal'),
			('003', 'IEPS', 'SI', 'SI', 'Federal');