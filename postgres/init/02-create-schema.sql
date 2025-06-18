CREATE SCHEMA IF NOT EXISTS dawa_replication;
CREATE TABLE dawa_replication.transactions(
  txid integer PRIMARY KEY,
  ts timestamptz);
CREATE TABLE dawa_replication.source_transactions(
  source_txid integer,
  local_txid integer NOT NULL,
  entity text NOT NULL,
  type text NOT NULL,
  PRIMARY KEY (source_txid, entity));
CREATE TYPE dawa_replication.operation_type AS ENUM ('insert', 'update', 'delete');
create table adgangsadresse(
id uuid,
status integer,
oprettet timestamp,
ændret timestamp,
ikrafttrædelsesdato timestamp,
kommunekode text,
vejkode text,
husnr text,
supplerendebynavn text,
postnr text,
ejerlavkode integer,
matrikelnr text,
esrejendomsnr text,
etrs89koordinat_øst double precision,
etrs89koordinat_nord double precision,
nøjagtighed text,
kilde integer,
husnummerkilde integer,
tekniskstandard text,
tekstretning double precision,
adressepunktændringsdato timestamp,
esdhreference text,
journalnummer text,
højde double precision,
adgangspunktid uuid,
supplerendebynavn_dagi_id text,
vejpunkt_id uuid,
navngivenvej_id uuid,
PRIMARY KEY(id)
);
create table adresse(
id uuid,
status integer,
oprettet timestamp,
ændret timestamp,
ikrafttrædelsesdato timestamp,
adgangsadresseid uuid,
etage text,
dør text,
kilde integer,
esdhreference text,
journalnummer text,
PRIMARY KEY(id)
);
create table afstemningsområde(
ændret text,
geo_ændret text,
geo_version integer,
visueltcenter geometry(geometry, 25832),
bbox geometry(geometry, 25832),
geometri geometry(geometry, 25832),
dagi_id text,
nummer text,
navn text,
afstemningsstednavn text,
afstemningsstedadresse text,
kommunekode text,
opstillingskreds_dagi_id text,
PRIMARY KEY(kommunekode, nummer)
);
create table afstemningsområdetilknytning(
adgangsadresseid uuid,
kommunekode text,
afstemningsområdenummer text,
PRIMARY KEY(adgangsadresseid, kommunekode, afstemningsområdenummer)
);
create table brofasthed(
stedid uuid,
brofast boolean,
PRIMARY KEY(stedid)
);
create table bygning(
id text,
bygningstype text,
metode3d text,
målested text,
bbrbygning_id uuid,
synlig boolean,
overlap boolean,
geometri geometry(geometryz, 25832),
PRIMARY KEY(id)
);
create table bygningtilknytning(
bygningid integer,
adgangsadresseid uuid,
PRIMARY KEY(bygningid, adgangsadresseid)
);
create table dagi_postnummer(
ændret text,
geo_ændret text,
geo_version integer,
visueltcenter geometry(geometry, 25832),
bbox geometry(geometry, 25832),
geometri geometry(geometry, 25832),
dagi_id text,
nr text,
navn text,
PRIMARY KEY(nr)
);
create table dar_adresse_aktuel(
id uuid,
status integer,
dørbetegnelse text,
dørpunkt_id uuid,
etagebetegnelse text,
fk_bbr_bygning_bygning uuid,
husnummer_id uuid,
PRIMARY KEY(id)
);
create table dar_adresse_historik(
rowkey integer,
virkningstart timestamptz,
virkningslut timestamptz,
id uuid,
status integer,
dørbetegnelse text,
dørpunkt_id uuid,
etagebetegnelse text,
fk_bbr_bygning_bygning uuid,
husnummer_id uuid,
PRIMARY KEY(rowkey)
);
create table dar_adressepunkt_aktuel(
id uuid,
status integer,
oprindelse_kilde text,
oprindelse_nøjagtighedsklasse text,
oprindelse_registrering timestamptz,
oprindelse_tekniskstandard text,
position geometry(point, 25832),
PRIMARY KEY(id)
);
create table dar_adressepunkt_historik(
rowkey integer,
virkningstart timestamptz,
virkningslut timestamptz,
id uuid,
status integer,
oprindelse_kilde text,
oprindelse_nøjagtighedsklasse text,
oprindelse_registrering timestamptz,
oprindelse_tekniskstandard text,
position geometry(point, 25832),
PRIMARY KEY(rowkey)
);
create table dar_darafstemningsområde_aktuel(
id uuid,
status integer,
afstemningsområde text,
afstemningsområdenummer integer,
navn text,
PRIMARY KEY(id)
);
create table dar_darafstemningsområde_historik(
rowkey integer,
virkningstart timestamptz,
virkningslut timestamptz,
id uuid,
status integer,
afstemningsområde text,
afstemningsområdenummer integer,
navn text,
PRIMARY KEY(rowkey)
);
create table dar_darkommuneinddeling_aktuel(
id uuid,
status integer,
kommuneinddeling text,
kommunekode text,
navn text,
PRIMARY KEY(id)
);
create table dar_darkommuneinddeling_historik(
rowkey integer,
virkningstart timestamptz,
virkningslut timestamptz,
id uuid,
status integer,
kommuneinddeling text,
kommunekode text,
navn text,
PRIMARY KEY(rowkey)
);
create table dar_darmenighedsrådsafstemningsområde_aktuel(
id uuid,
status integer,
mrafstemningsområde text,
mrafstemningsområdenummer integer,
navn text,
PRIMARY KEY(id)
);
create table dar_darmenighedsrådsafstemningsområde_historik(
rowkey integer,
virkningstart timestamptz,
virkningslut timestamptz,
id uuid,
status integer,
mrafstemningsområde text,
mrafstemningsområdenummer integer,
navn text,
PRIMARY KEY(rowkey)
);
create table dar_darsogneinddeling_aktuel(
id uuid,
status integer,
navn text,
sogneinddeling text,
sognekode text,
PRIMARY KEY(id)
);
create table dar_darsogneinddeling_historik(
rowkey integer,
virkningstart timestamptz,
virkningslut timestamptz,
id uuid,
status integer,
navn text,
sogneinddeling text,
sognekode text,
PRIMARY KEY(rowkey)
);
create table dar_husnummer_aktuel(
id uuid,
status integer,
adgangspunkt_id uuid,
darafstemningsområde_id uuid,
darkommune_id uuid,
darmenighedsrådsafstemningsområde_id uuid,
darsogneinddeling_id uuid,
fk_bbr_bygning_adgangtilbygning text,
fk_bbr_tekniskanlæg_adgangtiltekniskanlæg text,
fk_geodk_bygning_geodanmarkbygning text,
fk_geodk_vejmidte_vejmidte text,
fk_mu_jordstykke_foreløbigtplaceretpåjordstykke text,
fk_mu_jordstykke_jordstykke text,
husnummerretning geometry(point, 25832),
husnummertekst text,
navngivenvej_id uuid,
postnummer_id uuid,
supplerendebynavn_id uuid,
vejpunkt_id uuid,
PRIMARY KEY(id)
);
create table dar_husnummer_historik(
rowkey integer,
virkningstart timestamptz,
virkningslut timestamptz,
id uuid,
status integer,
adgangspunkt_id uuid,
darafstemningsområde_id uuid,
darkommune_id uuid,
darmenighedsrådsafstemningsområde_id uuid,
darsogneinddeling_id uuid,
fk_bbr_bygning_adgangtilbygning text,
fk_bbr_tekniskanlæg_adgangtiltekniskanlæg text,
fk_geodk_bygning_geodanmarkbygning text,
fk_geodk_vejmidte_vejmidte text,
fk_mu_jordstykke_foreløbigtplaceretpåjordstykke text,
fk_mu_jordstykke_jordstykke text,
husnummerretning geometry(point, 25832),
husnummertekst text,
navngivenvej_id uuid,
postnummer_id uuid,
supplerendebynavn_id uuid,
vejpunkt_id uuid,
PRIMARY KEY(rowkey)
);
create table dar_navngivenvej_aktuel(
id uuid,
status integer,
administreresafkommune text,
beskrivelse text,
retskrivningskontrol text,
udtaltvejnavn text,
vejadresseringsnavn text,
vejnavn text,
vejnavnebeliggenhed_oprindelse_kilde text,
vejnavnebeliggenhed_oprindelse_nøjagtighedsklasse text,
vejnavnebeliggenhed_oprindelse_registrering timestamptz,
vejnavnebeliggenhed_oprindelse_tekniskstandard text,
vejnavnebeliggenhed_vejnavnelinje geometry(geometry, 25832),
vejnavnebeliggenhed_vejnavneområde geometry(geometry, 25832),
vejnavnebeliggenhed_vejtilslutningspunkter geometry(geometry, 25832),
PRIMARY KEY(id)
);
create table dar_navngivenvej_historik(
rowkey integer,
virkningstart timestamptz,
virkningslut timestamptz,
id uuid,
status integer,
administreresafkommune text,
beskrivelse text,
retskrivningskontrol text,
udtaltvejnavn text,
vejadresseringsnavn text,
vejnavn text,
vejnavnebeliggenhed_oprindelse_kilde text,
vejnavnebeliggenhed_oprindelse_nøjagtighedsklasse text,
vejnavnebeliggenhed_oprindelse_registrering timestamptz,
vejnavnebeliggenhed_oprindelse_tekniskstandard text,
vejnavnebeliggenhed_vejnavnelinje geometry(geometry, 25832),
vejnavnebeliggenhed_vejnavneområde geometry(geometry, 25832),
vejnavnebeliggenhed_vejtilslutningspunkter geometry(geometry, 25832),
PRIMARY KEY(rowkey)
);
create table dar_navngivenvejkommunedel_aktuel(
id uuid,
status integer,
kommune text,
navngivenvej_id uuid,
vejkode text,
PRIMARY KEY(id)
);
create table dar_navngivenvejkommunedel_historik(
rowkey integer,
virkningstart timestamptz,
virkningslut timestamptz,
id uuid,
status integer,
kommune text,
navngivenvej_id uuid,
vejkode text,
PRIMARY KEY(rowkey)
);
create table dar_navngivenvejpostnummerrelation_aktuel(
id uuid,
status integer,
navngivenvej_id uuid,
postnummer_id uuid,
PRIMARY KEY(id)
);
create table dar_navngivenvejpostnummerrelation_historik(
rowkey integer,
virkningstart timestamptz,
virkningslut timestamptz,
id uuid,
status integer,
navngivenvej_id uuid,
postnummer_id uuid,
PRIMARY KEY(rowkey)
);
create table dar_navngivenvejsupplerendebynavnrelation_aktuel(
id uuid,
status integer,
navngivenvej_id uuid,
supplerendebynavn_id uuid,
PRIMARY KEY(id)
);
create table dar_navngivenvejsupplerendebynavnrelation_historik(
rowkey integer,
virkningstart timestamptz,
virkningslut timestamptz,
id uuid,
status integer,
navngivenvej_id uuid,
supplerendebynavn_id uuid,
PRIMARY KEY(rowkey)
);
create table dar_postnummer_aktuel(
id uuid,
status integer,
navn text,
postnr integer,
postnummerinddeling integer,
PRIMARY KEY(id)
);
create table dar_postnummer_historik(
rowkey integer,
virkningstart timestamptz,
virkningslut timestamptz,
id uuid,
status integer,
navn text,
postnr integer,
postnummerinddeling integer,
PRIMARY KEY(rowkey)
);
create table dar_reserveretvejnavn_aktuel(
id uuid,
status integer,
navneområde text,
reservationudløbsdato timestamptz,
reserveretafkommune text,
reserveretnavn text,
reserveretudtaltnavn text,
reserveretvejadresseringsnavn text,
retskrivningskontrol text,
PRIMARY KEY(id)
);
create table dar_reserveretvejnavn_historik(
rowkey integer,
virkningstart timestamptz,
virkningslut timestamptz,
id uuid,
status integer,
navneområde text,
reservationudløbsdato timestamptz,
reserveretafkommune text,
reserveretnavn text,
reserveretudtaltnavn text,
reserveretvejadresseringsnavn text,
retskrivningskontrol text,
PRIMARY KEY(rowkey)
);
create table dar_supplerendebynavn_aktuel(
id uuid,
status integer,
navn text,
supplerendebynavn1 text,
PRIMARY KEY(id)
);
create table dar_supplerendebynavn_historik(
rowkey integer,
virkningstart timestamptz,
virkningslut timestamptz,
id uuid,
status integer,
navn text,
supplerendebynavn1 text,
PRIMARY KEY(rowkey)
);
create table ejerlav(
kode integer,
navn text,
geo_version integer,
geo_ændret timestamptz,
ændret timestamptz,
visueltcenter geometry(geometry, 25832),
bbox geometry(geometry, 25832),
geometri geometry(geometry, 25832),
PRIMARY KEY(kode)
);
create table højde(
husnummerid uuid,
højde double precision,
PRIMARY KEY(husnummerid)
);
create table ikke_brofast_husnummer(
husnummerid uuid,
PRIMARY KEY(husnummerid)
);
create table jordstykke(
ejerlavkode integer,
matrikelnr text,
kommunekode text,
regionskode text,
sognekode text,
retskredskode text,
esrejendomsnr text,
udvidet_esrejendomsnr text,
sfeejendomsnr text,
geometri geometry(geometry, 25832),
featureid text,
fælleslod boolean,
moderjordstykke integer,
registreretareal integer,
arealberegningsmetode text,
vejareal integer,
vejarealberegningsmetode text,
vandarealberegningsmetode text,
visueltcenter geometry(geometry, 25832),
bbox geometry(geometry, 25832),
PRIMARY KEY(ejerlavkode, matrikelnr)
);
create table jordstykketilknytning(
ejerlavkode integer,
matrikelnr text,
adgangsadresseid uuid,
PRIMARY KEY(ejerlavkode, matrikelnr, adgangsadresseid)
);
create table kommune(
ændret text,
geo_ændret text,
geo_version integer,
visueltcenter geometry(geometry, 25832),
bbox geometry(geometry, 25832),
geometri geometry(geometry, 25832),
dagi_id text,
kode text,
navn text,
regionskode text,
udenforkommuneinddeling boolean,
PRIMARY KEY(kode)
);
create table kommunetilknytning(
adgangsadresseid uuid,
kommunekode text,
PRIMARY KEY(adgangsadresseid, kommunekode)
);
create table landpostnummer(
ændret text,
geo_ændret text,
geo_version integer,
visueltcenter geometry(geometry, 25832),
bbox geometry(geometry, 25832),
geometri geometry(geometry, 25832),
nr text,
navn text,
PRIMARY KEY(nr)
);
create table menighedsrådsafstemningsområde(
ændret text,
geo_ændret text,
geo_version integer,
visueltcenter geometry(geometry, 25832),
bbox geometry(geometry, 25832),
geometri geometry(geometry, 25832),
dagi_id text,
nummer text,
navn text,
afstemningsstednavn text,
kommunekode text,
sognekode text,
PRIMARY KEY(kommunekode, nummer)
);
create table menighedsrådsafstemningsområdetilknytning(
adgangsadresseid uuid,
kommunekode text,
menighedsrådsafstemningsområdenummer text,
PRIMARY KEY(adgangsadresseid, kommunekode, menighedsrådsafstemningsområdenummer)
);
create table navngivenvej(
id uuid,
darstatus text,
oprettet timestamptz,
ændret timestamptz,
navn text,
adresseringsnavn text,
administrerendekommune text,
beskrivelse text,
retskrivningskontrol text,
udtaltvejnavn text,
beliggenhed_oprindelse_kilde text,
beliggenhed_oprindelse_nøjagtighedsklasse text,
beliggenhed_oprindelse_registrering timestamptz,
beliggenhed_oprindelse_tekniskstandard text,
PRIMARY KEY(id)
);
create table opstillingskreds(
ændret text,
geo_ændret text,
geo_version integer,
visueltcenter geometry(geometry, 25832),
bbox geometry(geometry, 25832),
geometri geometry(geometry, 25832),
dagi_id text,
nummer text,
kode text,
navn text,
valgkredsnummer text,
storkredsnummer text,
kredskommunekode text,
PRIMARY KEY(kode)
);
create table opstillingskredstilknytning(
adgangsadresseid uuid,
opstillingskredskode text,
PRIMARY KEY(adgangsadresseid, opstillingskredskode)
);
create table politikreds(
ændret text,
geo_ændret text,
geo_version integer,
visueltcenter geometry(geometry, 25832),
bbox geometry(geometry, 25832),
geometri geometry(geometry, 25832),
dagi_id text,
kode text,
navn text,
PRIMARY KEY(kode)
);
create table politikredstilknytning(
adgangsadresseid uuid,
politikredskode text,
PRIMARY KEY(adgangsadresseid, politikredskode)
);
create table postnummer(
nr text,
navn text,
stormodtager boolean,
PRIMARY KEY(nr)
);
create table postnummertilknytning(
adgangsadresseid uuid,
postnummer text,
PRIMARY KEY(adgangsadresseid, postnummer)
);
create table region(
ændret text,
geo_ændret text,
geo_version integer,
visueltcenter geometry(geometry, 25832),
bbox geometry(geometry, 25832),
geometri geometry(geometry, 25832),
dagi_id text,
kode text,
navn text,
PRIMARY KEY(kode)
);
create table regionstilknytning(
adgangsadresseid uuid,
regionskode text,
PRIMARY KEY(adgangsadresseid, regionskode)
);
create table retskreds(
ændret text,
geo_ændret text,
geo_version integer,
visueltcenter geometry(geometry, 25832),
bbox geometry(geometry, 25832),
geometri geometry(geometry, 25832),
dagi_id text,
kode text,
navn text,
PRIMARY KEY(kode)
);
create table retskredstilknytning(
adgangsadresseid uuid,
retskredskode text,
PRIMARY KEY(adgangsadresseid, retskredskode)
);
create table sogn(
ændret text,
geo_ændret text,
geo_version integer,
visueltcenter geometry(geometry, 25832),
bbox geometry(geometry, 25832),
geometri geometry(geometry, 25832),
dagi_id text,
kode text,
navn text,
PRIMARY KEY(kode)
);
create table sognetilknytning(
adgangsadresseid uuid,
sognekode text,
PRIMARY KEY(adgangsadresseid, sognekode)
);
create table sted(
id uuid,
hovedtype text,
undertype text,
bebyggelseskode integer,
indbyggerantal integer,
visueltcenter geometry(geometry, 25832),
bbox geometry(geometry, 25832),
geometri geometry(geometry, 25832),
PRIMARY KEY(id)
);
create table stednavn(
stedid uuid,
navn text,
navnestatus text,
brugsprioritet text,
PRIMARY KEY(stedid, navn)
);
create table stednavntilknytning(
stednavn_id uuid,
adgangsadresse_id uuid,
PRIMARY KEY(stednavn_id, adgangsadresse_id)
);
create table stedtilknytning(
stedid uuid,
adgangsadresseid uuid,
PRIMARY KEY(stedid, adgangsadresseid)
);
create table storkreds(
ændret text,
geo_ændret text,
geo_version integer,
visueltcenter geometry(geometry, 25832),
bbox geometry(geometry, 25832),
geometri geometry(geometry, 25832),
nummer text,
navn text,
regionskode text,
valglandsdelsbogstav text,
PRIMARY KEY(nummer)
);
create table storkredstilknytning(
adgangsadresseid uuid,
storkredsnummer text,
PRIMARY KEY(adgangsadresseid, storkredsnummer)
);
create table supplerendebynavn(
ændret text,
geo_ændret text,
geo_version integer,
visueltcenter geometry(geometry, 25832),
bbox geometry(geometry, 25832),
geometri geometry(geometry, 25832),
dagi_id text,
navn text,
kommunekode text,
PRIMARY KEY(dagi_id)
);
create table supplerendebynavntilknytning(
adgangsadresseid uuid,
dagi_id text,
PRIMARY KEY(adgangsadresseid, dagi_id)
);
create table valglandsdel(
ændret text,
geo_ændret text,
geo_version integer,
visueltcenter geometry(geometry, 25832),
bbox geometry(geometry, 25832),
geometri geometry(geometry, 25832),
bogstav text,
navn text,
PRIMARY KEY(bogstav)
);
create table valglandsdelstilknytning(
adgangsadresseid uuid,
valglandsdelsbogstav text,
PRIMARY KEY(adgangsadresseid, valglandsdelsbogstav)
);
create table vask_adresse_historik(
husnummerid uuid,
etage text,
dør text,
rowkey integer,
id uuid,
adgangspunkt_status integer,
husnummer_status integer,
kommunekode text,
vejkode text,
vejnavn text,
adresseringsvejnavn text,
husnr text,
supplerendebynavn text,
postnr text,
postnrnavn text,
virkningstart timestamptz,
virkningslut timestamptz,
PRIMARY KEY(rowkey)
);
create table vask_husnummer_historik(
rowkey integer,
id uuid,
adgangspunkt_status integer,
husnummer_status integer,
kommunekode text,
vejkode text,
vejnavn text,
adresseringsvejnavn text,
husnr text,
supplerendebynavn text,
postnr text,
postnrnavn text,
virkningstart timestamptz,
virkningslut timestamptz,
PRIMARY KEY(rowkey)
);
create table vejmidte(
kommunekode text,
vejkode text,
geometri geometry(geometryz, 25832),
PRIMARY KEY(kommunekode, vejkode)
);
create table vejpunkt(
id uuid,
kilde text,
tekniskstandard text,
nøjagtighedsklasse text,
position geometry(geometry, 25832),
PRIMARY KEY(id)
);
create table vejstykke(
id text,
kommunekode text,
kode text,
oprettet timestamp,
ændret timestamp,
navn text,
adresseringsnavn text,
navngivenvej_id uuid,
PRIMARY KEY(kommunekode, kode)
);
create table vejstykkepostnummerrelation(
kommunekode text,
vejkode text,
postnr text,
PRIMARY KEY(kommunekode, vejkode, postnr)
);
create table zone(
ændret text,
geo_ændret text,
geo_version integer,
visueltcenter geometry(geometry, 25832),
bbox geometry(geometry, 25832),
geometri geometry(geometry, 25832),
zone text,
PRIMARY KEY(zone)
);
create table zonetilknytning(
adgangsadresseid uuid,
zone text,
PRIMARY KEY(adgangsadresseid, zone)
)