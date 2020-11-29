;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Patricio Ferraggi"
      user-mail-address "pattferraggi@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)
(doom-themes-neotree-config)
(setq doom-themes-neotree-file-icons t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;;;;;;;;;;;;;
;; Haskell ;;
;;;;;;;;;;;;;

;; Autocompletion(company)
(setq company-idle-delay 0.5
      company-minimum-prefix-length 2
      ;; company-show-numbers t
      )

(map! :leader
      (:after lsp-mode
       (:prefix ("l" . "LSP UI")
          :desc "Restart LSP server" "r" #'lsp-workspace-restart
          :desc "Execute code action" "a" #'lsp-execute-code-action
          :desc "Toggle doc mode" "d" #'lsp-ui-doc-mode
          :desc "Toggle sideline mode"  "s" #'lsp-ui-sideline-mode
          :desc "Glance at doc" "g" #'lsp-ui-doc-glance
          :desc "Toggle imenu"  "i" #'lsp-ui-imenu
        )))

;; lsp-ui
(after! lsp-ui
  (setq lsp-ui-doc-enable t
        lsp-ui-doc-glance 1
        lsp-ui-doc-delay 1
        lsp-ui-doc-include-signature t
        lsp-ui-doc-position 'Top
        lsp-ui-doc-border "#fdf5b1"
        lsp-ui-doc-max-width 65
        lsp-ui-doc-max-height 70
        lsp-ui-sideline-enable t
        lsp-ui-sideline-ignore-duplicate t
        lsp-ui-peek-enable t
        lsp-ui-flycheck-enable -1)

  (add-to-list 'lsp-ui-doc-frame-parameters '(left-fringe . 0))
)

(require 'lsp)
(require 'lsp-haskell)
(add-hook 'haskell-mode-hook #'lsp)
(add-hook 'haskell-literate-mode-hook #'lsp)

(use-package ormolu
  :hook (haskell-mode . ormolu-format-on-save-mode)
  :bind
  (:map haskell-mode-map
        ("C-c r" . ormolu-format-buffer)
        ))

(custom-set-variables
 '(haskell-tags-on-save t))

(map! :leader
       (:prefix ("j" . "JUMP")
          :desc "Jump to definition" "d" #'haskell-mode-jump-to-def
          ))
