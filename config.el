;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "pancho horrillo"
      user-mail-address "pancho@pancho.name")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!
(setq doom-font                 (font-spec :family "Iosevka Comfy"        :size 18)
      doom-variable-pitch-font  (font-spec :family "Iosevka Comfy Duo"    :size 20)
      doom-serif-font           (font-spec :family "Iosevka Comfy Motion" :size 18)
      doom-symbol-font          (font-spec :family "Noto Color Emoji"     :size 18)
      doom-big-font-increment   4)


;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-dracula)

;; Use `doom-colors' theme on treemacs (with icons!)
;; Possible caveat: https://github.com/hlissner/emacs-doom-themes/issues/392
(setq doom-themes-treemacs-theme 'doom-colors)

;; Enable Alarm Bell
;; https://www.emacswiki.org/emacs/AlarmBell
(setq visible-bell t)

;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Sentences.html
;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Fill-Commands.html
(setq sentence-end-double-space t
      colon-double-space        t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/sandbox/panchoh/org/")

;; https://ox-hugo.scripter.co/doc/dates/#date
;; https://www.gnu.org/software/emacs/manual/html_node/org/Closing-items.html
;; https://emacs.stackexchange.com/questions/47951/marking-a-todo-item-done-does-not-create-a-closing-timestamp-in-org-mode
(setq org-log-done 'time)
;; (setq org-log-done-with-time nil)

;; TODO
;; projectile-project-search-path SPC p D
(setq projectile-project-search-path `(("~/sandbox"  . 2)
                                       ("~/exercism" . 2)))

;; Workaround for #8356
;; https://github.com/doomemacs/doomemacs/issues/8356#issuecomment-2853333642
(setq projectile-auto-discover t)

;;; :ui doom-dashboard
(setq fancy-splash-image (file-name-concat doom-user-dir "pics/arrival_meme_vi_lowres.jpeg"))
;; Hide the banner, menu, benchmark and link to GitHub for as minimalistic a
;; startup screen as possible.
;; (remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-banner)
;; (remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)
;; (remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-loaded)
;; (remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-footer)

;; Disable smartparens
;; Seen on Discord on 2020-05-21, comment by hlissner
;; (remove-hook 'doom-first-buffer-hook #'smartparens-global-mode)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
;; (setq display-line-numbers-type 'visual)
(setq display-line-numbers-type 'nil)

;; IMO, modern editors have trained a bad habit into us all: a burning need for
;; completion all the time -- as we type, as we breathe, as we pray to the
;; ancient ones -- but how often do you *really* need that information? I say
;; rarely. So opt for manual completion:
;; (after! company
;;   setq company-idle-delay nil))

;; Disable invasive lsp-mode features
;; (setq lsp-ui-doc-enable nil)
;; (setq lsp-ui-doc-enable nil
;;       lsp-enable-symbol-highlighting nil
;;    ;; If an LSP server isn't present when I start a prog-mode buffer, you
;;    ;; don't need to tell me. I know. On some systems I don't care to have a
;;    ;; whole development environment for some ecosystems.
;;       +lsp-prompt-to-install-server 'quiet)

;; TODO: try this!
;; Ummmm...
;; (after! lsp-ui
;;   (setq lsp-ui-doc-position 'top)
;;   (setq lsp-ui-doc-show-with-cursor t))

(setq shell-file-name (executable-find "bash"))
(setq-default vterm-shell (executable-find "fish"))

;; 2021-12-06 @ Salamanca
;; https://pkg.go.dev/mvdan.cc/gofumpt
;; https://github.com/emacs-lsp/lsp-mode/blob/8f9259af6fc80a609c2c068d0f59c371205aca89/clients/lsp-go.el#L246
(after! lsp-go
  (setq lsp-go-use-gofumpt t)
  (setq-default eglot-workspace-configuration
                '((:gopls . ((gofumpt . t)))))
  )

;; Focus on the newly created window
(setq evil-split-window-below t
      evil-vsplit-window-right t)

;; Disable confirmation on exit
;; https://github.com/hlissner/doom-emacs/issues/2688
(setq confirm-kill-emacs nil)


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
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
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.


;; :tools magit
(use-package! magit-todos
  :after magit
  :config
  (setq magit-todos-keyword-suffix "\\(?:([^)]+)\\)?:?")                                  ; make colon optional
  (map! :map doom-leader-project-map :desc "List project todos" "t" #'magit-todos-list))  ; SPC p t

(after! magit
  ;; Enable granular diff-highlights for all hunks
  (setq magit-diff-refine-hunk 'all

        ;; Workaround for stash ops only available through magit-dispatch
        evil-collection-magit-use-z-for-folds t

        ;; Enable gravatars when viewing commits
        magit-revision-show-gravatars '("^Author:     " . "^Commit:     ")

        ;; Tell magit where to look for local repos
        magit-repository-directories `(("~/sandbox"  . 2)
                                       ("~/exercism" . 2))))

;; Tweak org-pomodoro
(after! org-pomodoro
  (setq org-pomodoro-start-sound t
        org-pomodoro-ticking-sound-p nil
        org-pomodoro-audio-player (executable-find "mpv-via-hdmi")
        org-pomodoro-start-sound (file-name-concat doom-user-dir "sounds/bell.mp3")
        org-pomodoro-finished-sound (file-name-concat doom-user-dir "sounds/bell.mp3")
        org-pomodoro-overtime-sound (file-name-concat doom-user-dir "sounds/bell.mp3")
        org-pomodoro-short-break-sound (file-name-concat doom-user-dir "sounds/bell.mp3")
        org-pomodoro-long-break-sound (file-name-concat doom-user-dir "sounds/bells.mp3")))

;; https://github.com/takaxp/org-tree-slide
(after! org-tree-slide
  ;; Don't increase the font size
  (setq +org-present-text-scale 0)
  ;; Remove indicators
  (setq org-tree-slide-indicator '(:next nil
                                   :previous nil
                                   :content nil)))

;; Provide a function to export all entries at once
(after! ox-hugo
  (defun org-hugo-export-all-wim-to-md ()
    (interactive)
    (org-hugo-export-wim-to-md :all-subtrees nil nil :noerror)))

;; (after! go-mode ; in this case the major mode and package named the same thing
;;   (set-ligatures! 'go-mode
;;     :def "func" ; function keyword
;;     :true "true" :false "false"
;;     ; this will replace not only definitions
;;     ; but corresponding functions as well
;;     :int "int" :str "string"
;;     :float "float" :bool "bool"
;;     :for "for"
;;     :return "return" :yield "yield"))

;; ediff init.el against current init.example.el
;; https://github.com/hlissner/doom-emacs/issues/581#issuecomment-645448095
(defun doom/ediff-init-and-example ()
  "ediff the current `init.el' with the example in doom-emacs-dir"
  (interactive)
  (ediff-files (file-name-concat doom-user-dir "init.el")
               (file-name-concat doom-emacs-dir "templates/init.example.el")))

(define-key! help-map
  "di"   #'doom/ediff-init-and-example
  )

;; https://github.com/oxalica/nil?tab=readme-ov-file#emacs-with-lsp-mode
;; SPC c f
(use-package! lsp-nix
  :defer t
  :custom
  (lsp-nix-nil-formatter ["nixfmt"])
  (lsp-nix-nil-max-mem 16384))


;; https://www.emacswiki.org/emacs/SmoothScrolling
(pixel-scroll-precision-mode)
(setq pixel-scroll-precision-large-scroll-height 40.0)


;; https://github.com/minad/vertico/issues/262
;; https://discourse.doomemacs.org/t/how-to-re-bind-keys/56
(map! :after vertico
      :map vertico-map
      "DEL" #'backward-delete-char
      "M-DEL" #'vertico-directory-delete-char)


;; https://github.com/doomemacs/doomemacs/issues/3609
;; https://github.com/doomemacs/doomemacs/commit/d70b2ff776b22fd725f9fa0c197e56d7624a56e0
;; (remove-hook 'doom-first-buffer-hook #'smartparens-global-mode)


;; https://github.com/doomemacs/doomemacs/issues/2673#issuecomment-595361339
;; https://www.emacswiki.org/emacs/WhiteSpace
;; (global-whitespace-mode +1)


;; https://github.com/artempyanykh/marksman?tab=readme-ov-file#existing-editor-integrations3
(use-package! markdown-mode
  :hook (markdown-mode . lsp)
  :config (require 'lsp-marksman))


(use-package! emojify
  :defer t
  :commands (emojify-mode global-emojify-mode)
  :init
  ;; Inline lambda to always skip confirmation
  (advice-add 'emojify--confirm-emoji-download :override (lambda () t))

  :hook (after-init . global-emojify-mode))
