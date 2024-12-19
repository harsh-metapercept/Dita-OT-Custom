# Extended CSS Plugin for DITA-OT [<img src="https://jason-fox.github.io/fox.jason.extend.css/extend-css.png" align="right" width="300">](https://extend-cssdita-ot.rtfd.io/)

[![license](https://img.shields.io/github/license/jason-fox/fox.jason.extend.css.svg)](http://www.apache.org/licenses/LICENSE-2.0)
[![DITA-OT 4.0](https://img.shields.io/badge/DITA--OT-4.0-green.svg)](http://www.dita-ot.org/4.0)
[![CI](https://github.com/jason-fox/fox.jason.extend.css/workflows/CI/badge.svg)](https://github.com/jason-fox/fox.jason.extend.css/actions?query=workflow%3ACI)

This is an abstract base [DITA-OT Plug-in](https://www.dita-ot.org/plugins) to extend HTML processing and allow
additional plug-ins to add an extra CSS stylesheet to the `<header>` of each HTML page. By default the plug-in does
nothing appart from creating a temporary file `extend.css.file` - it is designed to be extended so other plugins can add
CSS to the blank file.

It offers three extension-points for further CSS processing.

<details>
<summary><strong>Table of Contents</strong></summary>

-   [Install](#install)
    -   [Installing DITA-OT](#installing-dita-ot)
    -   [Installing the Plug-in](#installing-the-plug-in)
-   [Usage](#usage)
    -   [Extension points](#extension-points)
        -   [Example](#example)
-   [License](#license)

</details>

## Install

The DITA-OT Extended CSS plug-in has been tested against [DITA-OT 3.x](http://www.dita-ot.org/download). It is
recommended that you upgrade to the latest version.

### Installing DITA-OT

<a href="https://www.dita-ot.org"><img src="https://www.dita-ot.org/images/dita-ot-logo.svg" align="right" height="55"></a>

The DITA-OT Extended CSS plug-in is an extension for the DITA Open Toolkit.

-   Full installation instructions for downloading DITA-OT can be found
    [here](https://www.dita-ot.org/4.0/topics/installing-client.html).

    1.  Download the `dita-ot-4.0.zip` package from the project website at
        [dita-ot.org/download](https://www.dita-ot.org/download)
    2.  Extract the contents of the package to the directory where you want to install DITA-OT.
    3.  **Optional**: Add the absolute path for the `bin` directory to the _PATH_ system variable.

    This defines the necessary environment variable to run the `dita` command from the command line.

```console
curl -LO https://github.com/dita-ot/dita-ot/releases/download/4.0/dita-ot-4.0.zip
unzip -q dita-ot-4.0.zip
rm dita-ot-4.0.zip
```

### Installing the Plug-in

-   Run the plug-in installation commands:

```console
dita install https://github.com/jason-fox/jason.fox.extend.css/archive/master.zip
```

The `dita` command line tool requires no additional configuration.

---

## Usage

Run any HTML dita transform e.g.:

```console
PATH_TO_DITA_OT/bin/dita -f html5 -o out -i document.ditamap
```

Each HTML output file will include an additional line in the `<head>`

```html
<head>
    ...
    <link rel="stylesheet" type="text/css" href="common-extended.css">
</head>
```

The file `common-extended.css` will include any CSS added via the extension points described below.

### Extension points

CSS rules are always position dependent - the rule defined last in a file will supercede previous definitions. This
plug-in is offers three extension points where CSS can be appended to a file so that CSS rules can be added in order.

-   `extend.css.process.pre` - Runs an additional Ant target before the extended css processing stage.

-   `extend.css.process` - Runs an additional Ant target as part of the extended css processing stage.

-   `extend.css.process.post` - Runs an additional Ant target after the extended css processing.

#### Example

The following `plugin.xml` will invoke an extension point and append additional CSS to `extend.css.file` which is copied
to the output

##### `plugin.xml` Configuration

```xml
<plugin id="com.example.extended.css">
  <feature extension="ant.import" file="build.xml"/>
  <require plugin="fox.jason.extend.css"/>
  <feature extension="extend.css.process" value="example.css.copy"/>
</plugin>
```

##### ANT build file: `build.xml`

```xml
<project name="com.example.extended.css">
  <target name="example.css.copy">
    <loadfile property="extra.css" srcFile="/path/to/css"/>
    <echo append="true" message="${line.separator}${extra.css}" file="${extend.css.file}"/>
  </target>
</project>
```

Working examples can be found in the
[DITA-OT Swagger plug-in](https://github.com/jason-fox/fox.jason.passthrough.swagger) and
[DITA-OT Prism-JS plug-in](https://github.com/jason-fox/fox.jason.prismjs) repositories.

## License

[Apache 2.0](LICENSE) © 2019 - 2022 Jason Fox
