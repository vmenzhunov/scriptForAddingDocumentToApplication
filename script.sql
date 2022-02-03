DO $$
    DECLARE
        idDocument VARCHAR(100) := '';
        ownerId VARCHAR(100) := '';
        typeRefDocument VARCHAR(100) := 'contract';
        typeRefLetter VARCHAR(100) := 'customLetter';
        lastFileRefDocument VARCHAR(100) := '';
        lastFileRefLetter VARCHAR(100) := '';
        incomingDate timestamp := now();
        documentNumber VARCHAR(100) := '';
        dateLetter VARCHAR(100) := '';
        documentDate timestamp := to_timestamp(dateLetter, 'YYYY-MM-DD hh24:mi:ss')::timestamp without time zone;
        commentLetter VARCHAR(100) := '';
        
    BEGIN
        INSERT INTO public."Documents" (id, "ownerId", "typeRef", "lastFileRef", "isSended", "relatedDocumentId", "subtypeRef") VALUES (idDocument, ownerId, typeRefDocument, lastFileRefDocument, true, null, null);
        INSERT INTO public."LetterDocument" (id, "ownerId", "typeRef", "outgoingDate", "incomingDate", recipient, sender, "documentNumber", "documentDate", comment, "lastFileRef", created, rejected, "subtypeRef") VALUES (idDocument, ownerId, typeRefLetter, null, incomingDate, null, 'ФАУ Главгосэкспертиза России (Москва)', documentNumber, documentDate, commentLetter, lastFileRefLetter, incomingDate, false, '2');
        UPDATE "SignData"
        SET "signatureType" = 'gge'
        WHERE "signatureRef" in (
            SELECT id
            FROM "Signature"
            WHERE "fileRef" in (lastFileRefDocument, lastFileRefLetter)
        );
    END $$;
