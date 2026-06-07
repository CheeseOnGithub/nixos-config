{ ... }:

{
  programs.git = {
    enable = true;
    settings.user = {
      name = "CheeseOnGithub";
      email = "92813629+CheeseOnGithub@users.noreply.github.com";
    };
  };
}
