## Dictionnaire de données – SID Erasmus+

### 1. Contexte

Dans toute démarche décisionnelle et en particulier dans le cadre d’un SID, la formalisation d’un dictionnaire de données est un pilier de la gouvernance :

* **Garantir l’intelligibilité** des données pour tous les acteurs (DSI, métiers, externes).
* **Assurer la conformité RGPD** (description, usage, traçabilité de chaque donnée à caractère personnel).
* **Faciliter la maintenance** et l’auditabilité du SID dans le temps.

### 2. Démarche réalisée

* **Automatisation du catalogue** via dbt : extraction automatique de la structure des tables, vues et colonnes (type, description, table d’origine, etc.) pour l’ensemble du socle de données du SID.
* **Structuration** par domaines fonctionnels :

  * **Tables de seed** : `etablissement`, `etudiant`, `mobilite`, `table_autorisations_rls`
  * **Staging** : `stg_etablissement`, `stg_etudiant`, `stg_mobilite`, `stg_autorisation_rls`
  * **Modèles Data Vault** : `hub_etablissement`, `hub_etudiant`, `link_mobilite`, `sat_mobilite`
  * **Vue étoile BI** : `vw_fait_mobilite`
* **Documentation générée** : types des colonnes, logique de modélisation, gestion des clés, horodatage technique (`load_dts`), source de la donnée, etc.

### 3. Extrait du dictionnaire (exemple synthétique)

| Table / Vue                   | Colonne                                                                              | Type       | Description / Rôle                                     |
| ----------------------------- | ------------------------------------------------------------------------------------ | ---------- | ------------------------------------------------------ |
| **etablissement**             | oid\_etablissement                                                                   | text       | Identifiant unique établissement                       |
|                               | nom\_etablissement                                                                   | text       | Nom complet                                            |
|                               | pays                                                                                 | text       | Pays                                                   |
|                               | type\_organisation                                                                   | text       | Type d’établissement                                   |
| **etudiant**                  | id\_etudiant                                                                         | text       | Identifiant étudiant                                   |
|                               | prenom, nom                                                                          | text       | Prénom, nom                                            |
|                               | sexe, date\_naissance                                                                | text, date | Sexe, date de naissance                                |
|                               | nationalite, discipline                                                              | text       | Nationalité, discipline suivie                         |
| **mobilite**                  | id\_mobilite                                                                         | text       | Identifiant mobilité                                   |
|                               | id\_etudiant                                                                         | text       | Référence étudiant (FK)                                |
|                               | oid\_etablissement\_origine                                                          | text       | Etab. d’origine (FK)                                   |
|                               | oid\_etablissement\_accueil                                                          | text       | Etab. d’accueil (FK)                                   |
|                               | date\_debut, date\_fin                                                               | date       | Dates de mobilité                                      |
|                               | type\_mobilite, statut                                                               | text       | Type/statut                                            |
| **hub\_etablissement**        | oid\_etablissement                                                                   | text       | Clé hub établissement                                  |
| **hub\_etudiant**             | id\_etudiant                                                                         | text       | Clé hub étudiant                                       |
| **link\_mobilite**            | id\_mobilite, id\_etudiant, oid\_etablissement\_origine, oid\_etablissement\_accueil | text       | Relations clés mobilité                                |
| **sat\_mobilite**             | id\_mobilite, hashdiff\_mobilite, ...                                                | text, ...  | Historisation de l’état/payload mobilité               |
| **table\_autorisations\_rls** | user\_email, oid\_etablissement                                                      | text       | Table d’autorisations pour la sécurité (RLS)           |
| **vw\_fait\_mobilite**        | …                                                                                    | …          | Vue de restitution BI, détails mobilité + référentiels |

### 4. Spécificités RGPD

* **Données personnelles identifiées** : prénom, nom, sexe, date de naissance, nationalité, emails (table RLS).
* **Traçabilité technique** : `load_dts`, `source` sur toutes les tables et vues pour suivre chaque flux.
* **Sécurité d’accès** : gestion fine des habilitations via la table d’autorisations (RLS) – articulation avec la sécurité Power BI.
* **Facilité de purge/masquage** : le modèle permet d’isoler les données sensibles et d’automatiser l’effacement ou la pseudonymisation en cas de demande (droit à l’oubli).

### 5. Bonnes pratiques pour l’entretien

* Mettre en avant la **documentation automatisée** et la capacité à générer/maintenir un dictionnaire à jour via dbt.
* Souligner l’**alignement avec le RGPD** : chaque donnée est tracée, documentée, maîtrisée.
* Expliquer que ce dictionnaire servira :

  * à **faciliter les ateliers de cadrage** avec les métiers,
  * à **garantir la conformité légale** et l’auditabilité,
  * à **fluidifier l’intégration de nouvelles sources** et la maintenance du SI.

---

