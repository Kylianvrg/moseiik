# Utilisez une image officielle Rust
FROM rust:latest

# Définissez le répertoire de travail
WORKDIR /app

# Copiez le code source dans le conteneur
COPY ./src /app/src
COPY ./assets /app/assets
COPY ./tests /app/tests

# Copiez le fichier Cargo.toml
COPY Cargo.toml /app/Cargo.toml
COPY Cargo.lock /app/Cargo.lock

# Téléchargez le contenu du lien Internet et décompressez-le
RUN wget "https://filesender.renater.fr/download.php?token=178558c6-7155-4dca-9ecf-76cbebeb422e&files_ids=33679270" -O images.zip \
    && unzip images.zip \
    && rm images.zip


# Téléchargez les dépendances
RUN cargo build --release

# Point d'entrée pour exécuter cargo test avec des paramètres
ENTRYPOINT ["cargo", "test", "--release", "--"]

# Point d'entrée pour exécuter le fichier principal
CMD ["./target/release/moseiik"]


#build pour x_86
#docker buildx build --platform linux/amd64 -t your-image-name --load .

#docker run --platform linux/amd64 nom-image parametre1 parametre2
#docker run --platform linux/arm64 nom-image parametre1 parametre2




