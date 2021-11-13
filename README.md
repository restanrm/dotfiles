## Setup dotfiles on new machine

```bash
sh -c "$(curl -fsLS git.io/chezmoi)" -- init --apply restanrm
```

## Testing

If you want to test a fresh install on new machine, you can try the
devContainers of Microsoft®.

```bash
docker run --rm -it --user vscode --workdir /home/vscode mcr.microsoft.com/vscode/devcontainers/base:0-hirsute
```
