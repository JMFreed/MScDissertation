-- disparity in Uniprot database and genage database
-- naming nonmenclature aligned with the Uniprot database
USE DissertationDB

SELECT a.UniprotID, a.Name, b.UniprotID FROM genage_human a

LEFT OUTER JOIN tblProteins b ON b.UniprotID = a.UniprotID

WHERE b.UniprotID IS NULL

UPDATE genage_human
SET UniprotID = 'UBB_HUMAN'
WHERE UniprotID = 'UBIQ_HUMAN'

UPDATE genage_human
SET UniprotID = 'XRCC6_HUMAN'
WHERE UniprotID = 'KU70_HUMAN'

UPDATE genage_human
SET UniprotID = 'CCN2_HUMAN'
WHERE UniprotID = 'CTGF_HUMAN'

UPDATE genage_human
SET UniprotID = 'SIR6_HUMAN'
WHERE UniprotID = 'SIRT6_HUMAN'

UPDATE genage_human
SET UniprotID = 'S13A1_HUMAN'
WHERE UniprotID = 'A4D0X1_HUMAN'

UPDATE genage_human
SET UniprotID = 'GDF11_HUMAN'
WHERE UniprotID = 'A0A024RB20_HUMAN'