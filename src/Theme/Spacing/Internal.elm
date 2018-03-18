module Theme.Spacing.Internal
    exposing
        ( Theme(..)
        )


type Theme
    = Theme { padding : Maybe ( Float, Float, Float, Float ) }
