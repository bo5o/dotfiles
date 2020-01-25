def find_password():
    import subprocess

    return (
        subprocess.run(["pass", "github"], stdout=subprocess.PIPE)
        .stdout.decode()
        .strip()
    )


PASSWORD = find_password()
USERNAME = "cbows"
