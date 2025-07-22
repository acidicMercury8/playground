const fs = require('fs');
const path = require('path');
const cacache = require('cacache');
const mkdirp = require('mkdirp');

const cachePath = path.join(__dirname, '.npm', '_cacache')
const outputPath = path.join(__dirname, '.cache');

async function main()
{
    try
    {
        const packages = await cacache.ls(cachePath);
        for (const [key, metadata] of Object.entries(packages))
        {
            const keyFlat = key
                .split(':')
                .flatMap(part => part.split('/'));

            const { path: packagePath, integrity, time } = metadata;
            const protocol = `${keyFlat[2]}`;
            const registry = `${keyFlat[5]}`;

            var name = `${keyFlat[6]}`;
            var filename = `${keyFlat[8]}`;
            if (name[0] === '@')
            {
                var scope = `${keyFlat[6]}`;
                name = `${keyFlat[7]}`;
                filename = `${keyFlat[9]}`;
            }

            // console.log(`${protocol}://${registry}/${name}/${filename}`);
            // console.log(`    Key: ${key}`);
            // console.log(`    Path: ${packagePath}`);
            // console.log(`    Integrity: ${integrity}`);
            // console.log(`    Cached at: ${new Date(time).toISOString()}\n`);

            var packageDir = path.join(outputPath, registry, name);
            if (scope)
            {
                packageDir = path.join(outputPath, registry, scope, name);
            }
            await mkdirp.mkdirp(packageDir);

            const content = await cacache.get(cachePath, key);
            if (content.data)
            {
                fs.writeFileSync(path.join(packageDir, filename), content.data);
            }

            if (!scope)
            {
                console.log(`Exported: ${registry}/${name}/${filename}`);
            }
            else
            {
                console.log(`Exported: ${registry}/${scope}/${name}/${filename}`);
            }
        }
    }
    catch (error)
    {
        console.error('Error: ', error);
        process.exit(1);
    }
}

main();
