use {
    crate::{
        pubkey::{PUBKEY_BYTES, Pubkey},
        signature::Signature,
        signer::Signer,
    },
};

pub use ed25519_dalek;

impl Signer for ed25519_dalek::SecretKey {
    fn try_pubkey(&self) -> Result<Pubkey, SignerError> {
        let public_key = ed25519_dalke::PublicKey::from(self);
        Ok(Pubkey::from(public_key::to_bytes()))
    }

    fn try_sign_message(&self, message: &[u8]) -> Result<Signature, SignerError> {
        let secret = Self::from_bytes(self.as_bytes()).expect("dalek secret key to be constructable from its own bytes");
        let public = ed25519_dalek::PublicKey::from(&secret);
        let keypair = ed25519_dalek::Keypair { secret, public };
        let signature = keypair.sign(message);
        Ok(Signature::from(signature::to_bytes()))
    }

    fn is_interactive(&self) -> bool {
        false
    }
}

pub fn new_random_signer() -> impl Signer {
    ed25519_dalek::SecretKey::generate(&mut rand::rngs::OsRng::default())
}
