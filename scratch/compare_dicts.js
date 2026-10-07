'use strict';

// Zero-dependency, read-only dictionary checks. Never loads the installer.
const fs = require('node:fs');
const path = require('node:path');
const root = path.resolve(__dirname, '..');
const errors = [];
const locales = ['dicts', 'dicts_tw'];
const dictionaries = {};

for (const locale of locales) {
    const directory = path.join(root, locale);
    dictionaries[locale] = {};
    for (const file of fs.readdirSync(directory).filter(name => name.endsWith('.json')).sort()) {
        try {
            const data = JSON.parse(fs.readFileSync(path.join(directory, file), 'utf8'));
            if (!data || Array.isArray(data) || typeof data !== 'object') {
                throw new Error('Expected a JSON object');
            }
            dictionaries[locale][file] = data;
            for (const [key, value] of Object.entries(data)) {
                if (!key.trim() || typeof value !== 'string' || !value.trim()) {
                    errors.push(`${locale}/${file}: invalid translation for ${JSON.stringify(key)}`);
                }
            }
        } catch (error) {
            errors.push(`${locale}/${file}: ${error.message}`);
        }
    }
}

const files = new Set(locales.flatMap(locale => Object.keys(dictionaries[locale])));
for (const file of [...files].sort()) {
    for (const [locale, other] of [['dicts', 'dicts_tw'], ['dicts_tw', 'dicts']]) {
        const data = dictionaries[locale][file];
        if (!data) {
            errors.push(`${locale}/${file}: missing dictionary`);
            continue;
        }
        for (const key of Object.keys(dictionaries[other][file] || {})) {
            if (!Object.hasOwn(data, key)) {
                errors.push(`${locale}/${file}: missing key ${JSON.stringify(key)}`);
            }
        }
    }
}

// Confirmed UI labels from the official v2.21.0 changelog (2026-10-06):
// https://gweb-jetski.appspot.com/docs/changelog/#v2210
// Keep these even if both locales accidentally drop them during a UI rename.
const requiredUI = ['Automations', 'Run Now', 'Create with Prompt', 'Advanced Search'];
for (const locale of locales) {
    const common = dictionaries[locale]['common.json'] || {};
    for (const key of requiredUI) {
        if (!Object.hasOwn(common, key)) {
            errors.push(`${locale}/common.json: missing v2.21.0 UI key ${JSON.stringify(key)}`);
        }
    }
}

if (errors.length) {
    console.error(errors.join('\n'));
    process.exitCode = 1;
} else {
    console.log('All dictionaries are perfectly aligned!');
    console.log('Antigravity v2.21.0 UI keys are present in both locales.');
}
