from sqlalchemy import create_engine, Column, Integer, String, ForeignKey, Date
from sqlalchemy.engine import URL
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker, relationship
from sqlalchemy.orm import declarative_base


# Crear la base para las clases declarativas
Base = declarative_base()

# Configurar la conexión a SQL Server

connection_url = URL.create(
    "mssql+pyodbc",
    username="",
    password="",
    host="",
    database="python",
    query={"driver": "ODBC Driver 17 for SQL Server", "Trusted_Connection": "yes"}
)

engine = create_engine(connection_url)

Session = sessionmaker(bind=engine)
session = Session()

# Definir las Clases para las Tablas
class Cliente(Base):
    __tablename__ = 'clientes'
    
    id = Column(Integer, primary_key=True)
    nombre = Column(String)
    email = Column(String)
    telefono = Column(String)

    turnos = relationship('Turno', back_populates='cliente')

class Vehiculo(Base):
    __tablename__ = 'vehiculos'
    
    id = Column(Integer, primary_key=True)
    marca = Column(String)
    modelo = Column(String)
    año = Column(Integer)
    precio = Column(Integer)

    turnos = relationship('Turno', back_populates='vehiculo')

class Turno(Base):
    __tablename__ = 'turnos'
    
    id = Column(Integer, primary_key=True)
    fecha = Column(Date)
    tipo = Column(String)
    cliente_id = Column(Integer, ForeignKey('clientes.id'))
    vehículo_id = Column(Integer, ForeignKey('vehiculos.id'))

    cliente = relationship('Cliente', back_populates='turnos')
    vehiculo = relationship('Vehiculo', back_populates='turnos')

# Crear las tablas en SQL Server
Base.metadata.create_all(engine)

# CRUD Crear un cliente 
def crear_cliente(nombre, email, telefono):
    nuevo_cliente = Cliente(nombre=nombre, email=email, telefono=telefono)
    session.add(nuevo_cliente)
    session.commit()
    print(f"Cliente {nombre} creado exitosamente.")

# CRUD Leer un cliente 
def leer_clientes():
    clientes = session.query(Cliente).all()
    for cliente in clientes:
        print(f"ID: {cliente.id}, Nombre: {cliente.nombre}, Email: {cliente.email}, Teléfono: {cliente.telefono}")

# CRUD Actualizar un cliente 
def actualizar_cliente(cliente_id, nombre=None, email=None, telefono=None):
    cliente = session.query(Cliente).get(cliente_id)
    if nombre:
        cliente.nombre = nombre
    if email:
        cliente.email = email
    if telefono:
        cliente.telefono = telefono
    session.commit()
    print(f"Cliente {cliente_id} actualizado exitosamente.")

# CRUD Eliminar un cliente 
def eliminar_cliente(cliente_id):
    cliente = session.query(Cliente).get(cliente_id)
    session.delete(cliente)
    session.commit()
    print(f"Cliente {cliente_id} eliminado exitosamente.")

# CRUD Crear un vehiculo 
def crear_vehiculo(marca, modelo, año, precio):
    nuevo_vehiculo = Vehiculo(marca=marca, modelo=modelo, año=año, precio=precio)
    session.add(nuevo_vehiculo)
    session.commit()
    print(f"Vehículo {marca} {modelo} creado exitosamente.")

# CRUD Leer un vehiculo 
def leer_vehiculos():
    vehiculos = session.query(Vehiculo).all()
    for vehiculo in vehiculos:
        print(f"ID: {vehiculo.id}, Marca: {vehiculo.marca}, Modelo: {vehiculo.modelo}, Año: {vehiculo.año}, Precio: {vehiculo.precio}")

# CRUD Actualizar un vehiculo 
def actualizar_vehiculo(vehiculo_id, marca=None, modelo=None, año=None, precio=None):
    vehiculo = session.query(Vehiculo).get(vehiculo_id)
    if marca:
        vehiculo.marca = marca
    if modelo:
        vehiculo.modelo = modelo
    if año:
        vehiculo.año = año
    if precio:
        vehiculo.precio = precio
    session.commit()
    print(f"Vehículo {vehiculo_id} actualizado exitosamente.")

# CRUD Eliminar un vehiculo 
def eliminar_vehiculo(vehiculo_id):
    vehiculo = session.query(Vehiculo).get(vehiculo_id)
    session.delete(vehiculo)
    session.commit()
    print(f"Vehículo {vehiculo_id} eliminado exitosamente.")

# CRUD Crear un turno 
def crear_turno(fecha, tipo, cliente_id, vehículo_id):
    nuevo_turno = Turno(fecha=fecha, tipo=tipo, cliente_id=cliente_id, vehículo_id=vehículo_id)
    session.add(nuevo_turno)
    session.commit()
    print(f"Turno creado para el cliente {cliente_id} con vehículo {vehículo_id}.")

# CRUD Leer un turno
def leer_turnos():
    turnos = session.query(Turno).all()
    for turno in turnos:
        print(f"ID: {turno.id}, Fecha: {turno.fecha}, Tipo: {turno.tipo}, Cliente ID: {turno.cliente_id}, Vehículo ID: {turno.vehículo_id}")

# CRUD Actualizar un turno
def actualizar_turno(turno_id, fecha=None, tipo=None, cliente_id=None, vehículo_id=None):
    turno = session.query(Turno).get(turno_id)
    if fecha:
        turno.fecha = fecha
    if tipo:
        turno.tipo = tipo
    if cliente_id:
        turno.cliente_id = cliente_id
    if vehículo_id:
        turno.vehículo_id = vehículo_id
    session.commit()
    print(f"Turno {turno_id} actualizado exitosamente.")

# CRUD Eliminar un turno
def eliminar_turno(turno_id):
    turno = session.query(Turno).get(turno_id)
    session.delete(turno)
    session.commit()
    print(f"Turno {turno_id} eliminado exitosamente.")

# Probar la creación de un cliente
crear_cliente("Juan Pérez", "juan@example.com", "123456789")
leer_clientes()

# Probar la creación de un vehículo
crear_vehiculo("Toyota", "Corolla", 2020, 20000)
leer_vehiculos()

# Probar la creación de un turno
crear_turno("2024-08-17", "compra", 1, 1)
leer_turnos()