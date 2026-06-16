table 50004 "Fleet Management Setup"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Approved Budget"; Code[10])
        {
            TableRelation = "G/L Budget Name";
        }

        field(50020; "Commitments Budget"; Code[20])
        {
            TableRelation = "G/L Budget Name";
        }
        field(50030; "Activate Commitments Control"; Boolean)
        {

        }
        field(50031; "Budget Check Period"; Option)
        {
            OptionCaption = '" ,Weekly,Monthly,Quarter,Bi-Annual,Annual"';
            OptionMembers = " ",Weekly,Monthly,Quarter,"Bi-Annual",Annual;
        }
        field(50035; "Store Requisition Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(50036; "Archive Store Requisition"; Boolean)
        {
        }
        field(50037; "Purchase Requisition Nos"; Code[10])
        {
            Caption = 'Purchase Requisition Nos.';
            TableRelation = "No. Series";
        }
        field(50038; "Archive Purch. Requisition"; Boolean)
        {
        }
        field(50039; "Store Req Item Jnl Template"; Code[10])
        {
            TableRelation = "Item Journal Template";
        }
        field(50040; "Store Req Item Jnl Batch"; Code[10])
        {

            trigger OnLookup();
            var
                frmBatchList: Page "Item Journal Batches";
                lvItemJnlBatch: Record "Item Journal Batch";
            begin
                CLEAR(frmBatchList);
                lvItemJnlBatch.SETRANGE(lvItemJnlBatch."Journal Template Name", "Store Req Item Jnl Template");
                lvItemJnlBatch.SETRANGE(lvItemJnlBatch."Template Type", lvItemJnlBatch."Template Type"::Item);
                frmBatchList.SETRECORD(lvItemJnlBatch);
                frmBatchList.SETTABLEVIEW(lvItemJnlBatch);
                frmBatchList.LOOKUPMODE(TRUE);
                IF frmBatchList.RUNMODAL = ACTION::LookupOK THEN BEGIN
                    frmBatchList.GETRECORD(lvItemJnlBatch);
                    "Store Req Item Jnl Batch" := lvItemJnlBatch.Name;
                END;
                CLEAR(frmBatchList);
            end;
        }
        field(50041; "Store Req. Validity Period"; DateFormula)
        {
        }
        field(50042; "Purch. Req. Validity Period"; DateFormula)
        {
        }
        field(50044; "Purch. Order Validity Period"; DateFormula)
        {
        }
        field(50045; "Sales Quote Validity Period"; DateFormula)
        {
        }
        field(50046; "Service Quote Validity Period"; DateFormula)
        {
        }
        field(50047; "Bank Batch No. Series"; Code[11])
        {
            TableRelation = "No. Series";
        }
        field(50048; "Def Service Item Group Code"; Code[10])
        {
            Description = 'Default Service Item Group Code for creating Service Items for Fixed Assets';
            TableRelation = "Service Item Group";
        }
        field(50050; "Def Service Price Group Code"; Code[10])
        {
            Description = 'Default Service Price Group Code for creating Service Items for Fixed Assets';
            TableRelation = "Service Price Group";
        }
        field(50057; "Transfer Job to FA template"; Code[20])
        {
            TableRelation = "Gen. Journal Template" WHERE(Type = CONST(Assets));
        }
        field(50058; "Transfer Job to FA Batch"; Code[20])
        {
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Transfer Job to FA template"));
        }
        field(50059; "Store Req. Archive No. Series"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50060; "Bulk Invoice No Series"; Code[10])
        {
            Description = 'For auto-numbering bulk invoices';
            TableRelation = "No. Series";
        }
        field(50061; "Return Order Validity Period"; DateFormula)
        {
        }
        field(50062; "Store Return Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(50063; "Store Return Item Jnl Template"; Code[10])
        {
            TableRelation = "Item Journal Template" WHERE(Type = CONST(Item));
        }
        field(50064; "Store Return Item Jnl Batch"; Code[10])
        {

            trigger OnLookup();
            var
                frmBatchList: Page "Item Journal Batches";
                lvItemJnlBatch: Record "Item Journal Batch";
            begin
                CLEAR(frmBatchList);
                lvItemJnlBatch.SETRANGE(lvItemJnlBatch."Journal Template Name", "Store Return Item Jnl Template");
                lvItemJnlBatch.SETRANGE(lvItemJnlBatch."Template Type", lvItemJnlBatch."Template Type"::Item);
                frmBatchList.SETRECORD(lvItemJnlBatch);
                frmBatchList.SETTABLEVIEW(lvItemJnlBatch);
                frmBatchList.LOOKUPMODE(TRUE);
                IF frmBatchList.RUNMODAL = ACTION::LookupOK THEN BEGIN
                    frmBatchList.GETRECORD(lvItemJnlBatch);
                    "Store Return Item Jnl Batch" := lvItemJnlBatch.Name;
                END;
                CLEAR(frmBatchList);
            end;
        }
        field(50065; "Store Return Validity Period"; DateFormula)
        {
        }
        field(50066; "Store Return Archive No series"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(50067; "Budget Check On Purch. Req."; Boolean)
        {
        }
        field(50451; "Enable Budget Check"; Boolean)
        {
        }
        //scd.use.or.ug
        field(50452; "Release Budget"; Code[10])
        {
            TableRelation = "G/L Budget Name";
        }

        field(50454; "Vote on Account Budget"; Code[10])
        {
            TableRelation = "G/L Budget Name";
        }
        field(50455; "Supplementary Budget"; Code[10])
        {
            TableRelation = "G/L Budget Name";
        }
        field(50006; "Enable Automatic Bank Rec"; Boolean)
        {
        }
        field(50007; "WHT Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(50008; "WHT Percentage"; Decimal)
        {
        }
        field(50009; "Approved Payments Batch"; Code[10])
        {
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = CONST('GENERAL'));
        }
        field(50011; "WHT Percentage - Foreign"; Decimal)
        {
        }
        field(50012; "Foreign VAT Account No."; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }

        field(50015; "Populate Payment Dimensions"; Boolean)
        {
        }
        field(50321; "Shortcut Dimension 9 Code"; Code[20])
        {
            AccessByPermission = TableData 350 = R;
            Caption = 'Shortcut Dimension 9 Code';
            TableRelation = Dimension;

            trigger OnValidate();
            var
                Dim: Record Dimension;
                Text023: Label '%1\You cannot use the same dimension twice in the same setup.';
            begin
                IF Dim.CheckIfDimUsed("Shortcut Dimension 9 Code", 9, '', '', 0) THEN
                    ERROR(Text023, Dim.GetCheckDimErr);
                MODIFY;
            end;
        }

        field(50322; "Budget Assumption Nos."; Code[10])
        {
            AccessByPermission = TableData 270 = R;
            Caption = 'Budget Assumption Nos.';
            TableRelation = "No. Series";
        }
        field(50323; "Approved JV Batch"; Code[10])
        {
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = CONST('GENERAL'));
        }
        field(50324; "Approved JV Template"; Code[10])
        {
            TableRelation = "Gen. Journal Template";
        }
        field(50325; "Doc. Ref. No. series"; Code[50])
        {
            TableRelation = "No. Series";
        }
        field(50326; "Bank Trans. Ref. No. series"; Code[50])
        {
            TableRelation = "No. Series";
        }
        field(50327; "Edit Status"; Boolean)
        {
            Caption = 'Edit Status';
        }
        field(50328; "Approved Payments Template"; Code[10])
        {
            TableRelation = "Gen. Journal Template";
        }
        field(50329; "Store Req Job Jnl Template"; Code[10])
        {
            TableRelation = "Job Journal Template";
        }
        field(50330; "Store Req Job Jnl Batch"; Code[10])
        {

            trigger OnLookup();
            var
                frmBatchList: Page "Job Journal Batches";
                lvItemJnlBatch: Record "Job Journal Batch";
            begin
                CLEAR(frmBatchList);
                lvItemJnlBatch.SETRANGE(lvItemJnlBatch."Journal Template Name", "Store Req Job Jnl Template");
                frmBatchList.SETRECORD(lvItemJnlBatch);
                frmBatchList.SETTABLEVIEW(lvItemJnlBatch);
                frmBatchList.LOOKUPMODE(TRUE);
                IF frmBatchList.RUNMODAL = ACTION::LookupOK THEN BEGIN
                    frmBatchList.GETRECORD(lvItemJnlBatch);
                    "Store Req Job Jnl Batch" := lvItemJnlBatch.Name;
                END;
                CLEAR(frmBatchList);
            end;
        }
        field(50331; "Fuel Requisition Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50332; "Spare Part Requisition Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50334; "Spare Req Item Jnl Template"; Code[10])
        {
            TableRelation = "Item Journal Template" WHERE(Type = CONST(Item));
        }
        field(50335; "Spare Req Item Jnl Batch"; Code[10])
        {

            trigger OnLookup();
            var
                frmBatchList: Page "Item Journal Batches";
                lvItemJnlBatch: Record "Item Journal Batch";
            begin
                CLEAR(frmBatchList);
                lvItemJnlBatch.SETRANGE(lvItemJnlBatch."Journal Template Name", "Spare Req Item Jnl Template");
                lvItemJnlBatch.SETRANGE(lvItemJnlBatch."Template Type", lvItemJnlBatch."Template Type"::Item);
                frmBatchList.SETRECORD(lvItemJnlBatch);
                frmBatchList.SETTABLEVIEW(lvItemJnlBatch);
                frmBatchList.LOOKUPMODE(TRUE);
                IF frmBatchList.RUNMODAL = ACTION::LookupOK THEN BEGIN
                    frmBatchList.GETRECORD(lvItemJnlBatch);
                    "Spare Req Item Jnl Batch" := lvItemJnlBatch.Name;
                END;
                CLEAR(frmBatchList);
            end;
        }
        field(50336; "Fuel Req Item Jnl Template"; Code[10])
        {
            TableRelation = "Item Journal Template" WHERE(Type = CONST(Item));
        }
        field(50337; "Fuel Req Item Jnl Batch"; Code[10])
        {

            trigger OnLookup();
            var
                frmBatchList: Page "Item Journal Batches";
                lvItemJnlBatch: Record "Item Journal Batch";
            begin
                CLEAR(frmBatchList);
                lvItemJnlBatch.SETRANGE(lvItemJnlBatch."Journal Template Name", "Fuel Req Item Jnl Template");
                lvItemJnlBatch.SETRANGE(lvItemJnlBatch."Template Type", lvItemJnlBatch."Template Type"::Item);
                frmBatchList.SETRECORD(lvItemJnlBatch);
                frmBatchList.SETTABLEVIEW(lvItemJnlBatch);
                frmBatchList.LOOKUPMODE(TRUE);
                IF frmBatchList.RUNMODAL = ACTION::LookupOK THEN BEGIN
                    frmBatchList.GETRECORD(lvItemJnlBatch);
                    "Fuel Req Item Jnl Batch" := lvItemJnlBatch.Name;
                END;
                CLEAR(frmBatchList);
            end;
        }
        field(50338; "Maintenance Request No."; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(50339; "Job Card No."; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(50340; "Assignment No."; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(50341; "General Requisitions No."; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(50342; "Gen Req Item Jnl Template"; Code[10])
        {
            TableRelation = "Item Journal Template" WHERE(Type = CONST(Item));
        }
        field(50343; "Gen Req Item Jnl Batch"; Code[10])
        {

            trigger OnLookup();
            var
                frmBatchList: Page "Item Journal Batches";
                lvItemJnlBatch: Record "Item Journal Batch";
            begin
                CLEAR(frmBatchList);
                lvItemJnlBatch.SETRANGE(lvItemJnlBatch."Journal Template Name", "Gen Req Item Jnl Template");
                lvItemJnlBatch.SETRANGE(lvItemJnlBatch."Template Type", lvItemJnlBatch."Template Type"::Item);
                frmBatchList.SETRECORD(lvItemJnlBatch);
                frmBatchList.SETTABLEVIEW(lvItemJnlBatch);
                frmBatchList.LOOKUPMODE(TRUE);
                IF frmBatchList.RUNMODAL = ACTION::LookupOK THEN BEGIN
                    frmBatchList.GETRECORD(lvItemJnlBatch);
                    "Gen Req Item Jnl Batch" := lvItemJnlBatch.Name;
                END;
                CLEAR(frmBatchList);
            end;
        }
        field(50344; "Performance No."; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(50345; "Internal Hire Nos."; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(50346; "External Hire Nos."; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(50347; "Daily Assignment Nos."; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(50348; "Incident Nos."; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(50349; "Vehicle Movement Log Nos."; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(50350; "Inspection Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(50351; "Journey Management Nos."; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(50352; "Routine Service Tracker No."; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(50353; "Expiry Warning"; Integer) { }
        field(50354; "Send Expiry Notification"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50355; "Send Service Notification"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50356;"Complaint No."; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(50357;"Cash Purchase Nos"; Code[20])
        {
            TableRelation="No. Series".Code;

        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}