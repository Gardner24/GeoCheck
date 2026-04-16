-- 1. Habilitar la extensión geoespacial
CREATE EXTENSION IF NOT EXISTS postgis;

-- 2. Tablas clave del sistema
CREATE TABLE usuarios (
  id          SERIAL PRIMARY KEY,
  nombre      VARCHAR(100) NOT NULL,
  email       VARCHAR(150) UNIQUE NOT NULL,
  password    TEXT NOT NULL,
  rol         VARCHAR(20) DEFAULT 'colaborador',
  creado_en   TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE zonas (
  id          SERIAL PRIMARY KEY,
  nombre      VARCHAR(100) NOT NULL,
  origen      GEOGRAPHY(POINT, 4326) NOT NULL,
  radio_m     INTEGER DEFAULT 25,
  ssid_wifi   VARCHAR(100),
  activa      BOOLEAN DEFAULT TRUE
);

CREATE TABLE registros (
  id          SERIAL PRIMARY KEY,
  usuario_id  INTEGER REFERENCES usuarios(id),
  zona_id     INTEGER REFERENCES zonas(id),
  ubicacion   GEOGRAPHY(POINT, 4326) NOT NULL,
  valido      BOOLEAN,
  es_fraude   BOOLEAN DEFAULT FALSE,
  timestamp   TIMESTAMPTZ DEFAULT NOW()
);