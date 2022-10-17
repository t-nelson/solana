//! A trait for sanitizing values and members of over the wire messages.

use thiserror::Error;

#[derive(Clone, Copy, Debug)]
pub struct SanitizeConfig {
    pub require_static_program_ids: bool
}

impl Default for SanitizeConfig {
    fn default() -> Self {
        Self {
            require_static_program_ids: false,
        }
    }
}

#[derive(PartialEq, Debug, Error, Eq, Clone)]
pub enum SanitizeError {
    #[error("index out of bounds")]
    IndexOutOfBounds,
    #[error("value out of bounds")]
    ValueOutOfBounds,
    #[error("invalid value")]
    InvalidValue,
}

/// A trait for sanitizing values and members of over-the-wire messages.
///
/// Implementation should recursively descend through the data structure and
/// sanitize all struct members and enum clauses. Sanitize excludes signature-
/// verification checks, those are handled by another pass. Sanitize checks
/// should include but are not limited to:
///
/// - All index values are in range.
/// - All values are within their static max/min bounds.
pub trait Sanitize {
    fn sanitize(&self, _config: SanitizeConfig) -> Result<(), SanitizeError> {
        Ok(())
    }
}

impl<T: Sanitize> Sanitize for Vec<T> {
    fn sanitize(&self, config: SanitizeConfig) -> Result<(), SanitizeError> {
        for x in self.iter() {
            x.sanitize(config)?;
        }
        Ok(())
    }
}
