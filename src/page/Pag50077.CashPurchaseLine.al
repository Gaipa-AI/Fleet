page 50077 "Cash Purchase Line"
{
    Caption = 'Cash Purchase Line';
    PageType = ListPart;
    SourceTable = "Cash Purchase Line";
    //*
    AutoSplitKey = true;
    DelayedInsert = true;

    //*
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Selection; Rec.Selection)
                {
                    ApplicationArea = Basic;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Type field.';
                    Editable = DocumentStatus;

                    
                }
                field("Location "; Rec.Location)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Location field.';
                    //Editable = DocumentStatus;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                    Editable = DocumentStatus;
                    trigger OnValidate()
                    begin
                        if Rec."No." <> '' then
                            CheckForDuplicateItemOnLine(Rec."No."); // Check for duplicates\
                        exit;
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                    Editable = DocumentStatus;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                 field(PUOM;Rec.PUOM){
                    ApplicationArea = All;

                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quantity field.';
                    Editable = DocumentStatus;

                }
                field("Quote Qty"; Rec."Quote Qty")
                {
                    Editable = false;
                    Visible = false;

                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit Cost field.';
                    Editable = DocumentStatus;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field("Gen. Journal Batch"; Rec."Gen. Journal Batch")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Gen. Journal Batch field.';
                    //Editable = DocumentStatus and DocumentActionStatus;
                }
                field("Buy-From-Vendor-No."; Rec."Buy-From-Vendor-No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Buy-From-Vendor-No. field.';
                    //Editable = DocumentStatus and DocumentActionStatus;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posted field.';
                }
                field(Remarks;Rec."Approver's Remarks")
                {
                    ToolTip = 'Approvers remarks/comments';
                    ApplicationArea = All;
                  
                }
                field("Order No."; Rec."Order No.")
                {
                    Caption = 'Ext. Document No.';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posted field.';
                }
                field("Recipient Code"; Rec."Shortcut Dimension 4 Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Recipient Code';
                    Style = StrongAccent;
                    StyleExpr = true;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Create Journal Line")
            {
                Caption = 'Create Journal Line';
                Image = Journals;
                Visible = DocumentActionStatus;

                trigger OnAction()
                var
                    GenJTemplate: Text;
                    GenJBatch: Record "Gen. Journal Batch";
                    NoSeriesMgmt: Codeunit NoSeriesManagement;
                    NewDocumentNo: Code[20];
                    Genjline: Record "Gen. Journal Line";
                    Text001: Label 'Payment Journal line %1 has been Created';
                    LineSelected: Boolean; // Variable to track if any line is selected
                    
                begin
                    // Initialize the selection check
                    LineSelected := false;

                    // Iterate through the lines to check for selection
                    if Rec.FindSet() then begin
                        repeat
                            if Rec."Selection" then begin // Assuming "Selection" is the field that indicates if the line is selected
                                LineSelected := true; // Mark that at least one line is selected
                                                      // Proceed to create journal line for this selected line
                                Rec.TestField(Posted, false);
                                Rec.TestField(Type, Rec.Type::"G/L Account");
                                Rec.TestField("Gen. Journal Batch");
                                Rec.TestField(Amount);

                                GenJTemplate := 'PAYMENTS';

                                Clear(NewDocumentNo);
                                if GenJBatch.Get(GenJTemplate, Rec."Gen. Journal Batch") then begin
                                    GenJBatch.TestField("No. Series");
                                    NewDocumentNo := NoSeriesMgmt.GetnextNo(GenJBatch."No. Series", WorkDate, true);
                                end;

                                if NewDocumentNo = '' then
                                    Error('Document No. must be defined for batch %1', Rec."Gen. Journal Batch");

                                Genjline."Journal Template Name" := GenJTemplate;
                                Genjline."Journal Batch Name" := Rec."Gen. Journal Batch";
                                Genjline."Line No." := NextGnjlineNo(GenJTemplate, Rec."Gen. Journal Batch") + 10000;
                                Genjline."Posting Date" := Today;
                                Genjline."Document No." := NewDocumentNo;
                                Genjline."External Document No." := Rec."Document No.";
                                Genjline."Account Type" := Genjline."Account Type"::"G/L Account";
                                Genjline.Validate("Account No.", Rec."No.");
                                Genjline.Description := Rec.Description;
                                Genjline.Validate(Amount, Rec.Amount);
                                Genjline.Insert;

                                Commit();

                                Rec."Order No." := Genjline."Document No.";
                                Rec.Validate(Posted, true);
                                Rec.Modify;

                                if not CheckDocumentforClosure then
                                    DocumentClosure();

                                Message(Text001, Genjline."Document No.");
                            end;
                        until Rec.Next() = 0;
                    end;

                    // If no lines were selected, you can show a message
                    if not LineSelected then
                        Message('No lines selected for creating journal lines.');
                end;
            }

            action("Create Purchase Order")
            {
                Caption = 'Create Purchase Quote';
                Image = Invoice;
                Visible = DocumentActionStatus;

                trigger OnAction()
                var
                    PurchSetup: Record "Purchases & Payables Setup";
                    NoSeriesMgmt: Codeunit NoSeriesManagement;
                    OrderNo: Code[20];
                    Purchase: Record "Purchase Header";
                    PurchaseLine: Record "Purchase Line";
                    Text001: Label 'Purchase Quote %1 has been Created';
                    InventorySetup: Record "Inventory Setup";
                    LineSelected: Boolean; // Variable to track if any line is selected
                    Message: Text;
                    Text002: Label 'Purchase Quote %1 has been created do you want to open it';
                begin
                    Rec.TestField(Posted, false);
                    if not (Rec.Type in [Rec.Type::Item, Rec.Type::"Fixed Asset"]) then
                        error('Type cannot be G/L account');
                    Rec.TestField("Buy-From-Vendor-No.");
                    Rec.TestField(Amount);

                    InventorySetup.Get();
                   

                    PurchSetup.Get();
                    Clear(OrderNo);
                    OrderNo := NoSeriesMgmt.GetnextNo(PurchSetup."Quote Nos.", WorkDate, true);

                    // Initialize the Purchase Quote
                    Purchase.Init;
                    Purchase."Document Type" := Purchase."Document Type"::Quote;
                    Purchase."No." := OrderNo;
                    Purchase.Validate("Buy-from Vendor No.", Rec."Buy-From-Vendor-No.");
                    Purchase."Order Date" := WorkDate;
                    Purchase."Posting Date" := WorkDate;
                    Purchase."Document Date" := WorkDate;
                    Purchase.Validate("Location Code", Rec.Location);
                    Purchase."Cash Purchase No." := Rec."Document No.";
                    Purchase."Shortcut Dimension 1 Code" := Rec."Shortcut Dimension 1 Code";
                    Purchase."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
                    Purchase.Validate("Location Code", CashPurchase."Location Code");
                    Purchase."Expected Requirement Date":=CashPurchase."Expected Requisition Date";
                    Purchase.Insert(true);

                    // Check for selected lines
                    LineSelected := false; // Reset the line selected flag
                    if Rec.FindSet() then begin
                        repeat
                            if Rec."Selection" then begin // Assuming "Selection" is the field indicating if the line is selected
                                LineSelected := true; // Mark that at least one line is selected

                                // Initialize the Purchase Line
                                PurchaseLine.Init;
                                PurchaseLine.Validate("Document Type", Purchase."Document Type");
                                PurchaseLine.Validate("Document No.", Purchase."No.");
                                PurchaseLine.Validate("Pay-to Vendor No.", Rec."Buy-From-Vendor-No.");
                                PurchaseLine.Validate("Shortcut Dimension 1 Code", Rec."Shortcut Dimension 1 Code");
                                PurchaseLine.Validate("Shortcut Dimension 2 Code", Rec."Shortcut Dimension 2 Code");
                                PurchaseLine.Validate("Line No.", PurchaseLine."Line No." + 10000); // Adjust line number as needed

                                // Set the type based on the current record type
                                if Rec.Type = Rec.Type::Item then
                                    PurchaseLine.Validate(Type, PurchaseLine.Type::Item)
                                else
                                    if Rec.Type = Rec.Type::"Fixed Asset" then
                                        PurchaseLine.Validate(Type, PurchaseLine.Type::"Fixed Asset");

                                // Copy the necessary fields from the selected line
                                PurchaseLine.Validate("No.", Rec."No.");
                                PurchaseLine.Validate(Quantity, Rec."Quote Qty");
                                //PurchaseLine.Validate("Alternate Qty", Rec.Quantity);                               
                                PurchaseLine."Unit Cost (LCY)":= Rec."Unit Cost";
                                PurchaseLine.Validate(Amount, Rec.Amount);
                                PurchaseLine.Validate("Unit of Measure Code",Rec."Unit of Measure Code");
                                //PurchaseLine.Validate("Purch. Unit of Measure",Rec.PUOM);
                                //PurchaseLine.Validate("Purchase Requisition No.", Rec."Document No.");
                                //PurchaseLine.Validate("Location Code", InventorySetup."Store Location");
                                PurchaseLine.Insert(true);

                                // Update the Posted field for the selected line
                                Rec.Validate(Posted, true);
                                // Update the original record with the new Purchase Quote number
                                Rec."Order No." := Purchase."No.";
                                Rec.Modify; // Save the changes for the current line
                            end;
                        until Rec.Next() = 0;
                    end;

                    // If no lines were selected, show a message and exit
                    if not LineSelected then begin
                        Message('No lines selected for creating the Purchase Quote.');
                        exit; // Exit the action if no lines are selected
                    end;


                    if not CheckDocumentforClosure then
                        DocumentClosure();

                    Message(Text001, Purchase."No.");
                    //Message:= 'Purchase Quote %1 created from Cash Purchase %2. Do you want to open the quote?' + Purchase."No."+ ' ';
                    if Confirm(Text002, true) then begin
                            
                            //Purchase.SetRange("Document Type", SpareReqHeader."Document Type"::"Purchase Requisition");
                            Purchase.SetRange("No.", Purchase."No.");
                            Page.Run(Page::"Purchase Quotes", Purchase);
                        end;
                end;
            }
            action("Select All")
            {
                ApplicationArea = All;
                Caption = 'Select All';
                //AccessByPermission = TableData "BOM Component" = R;
                Image = SelectReport;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                PromotedOnly = false;
                Visible = DocumentActionStatus;

                trigger OnAction()
                var
                    CashLines: Record "Cash Purchase Line";
                begin
                    //PurchaseLines.SetRange("Document Type", Rec."Document Type");
                    CashLines.SetRange("Document No.", Rec."Document No.");
                    if CashLines.FindSet then
                        repeat
                            CashLines.Selection := true;
                            CashLines.Modify until CashLines.Next = 0
                end;
            }
            action("UnSelect All")
            {
                ApplicationArea = All;
                Caption = 'UnSelect All';
                //AccessByPermission = TableData "BOM Component" = R;
                Image = SelectReport;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                PromotedOnly = false;
                Visible = DocumentActionStatus;

                trigger OnAction()
                var
                    CashLines: Record "Cash Purchase Line";
                begin
                    // PurchaseLines.SetRange("Document Type", Rec."Document Type");
                    CashLines.SetRange("Document No.", Rec."Document No.");
                    if CashLines.FindSet then
                        repeat
                            CashLines.Selection := false;
                            CashLines.Modify until CashLines.Next = 0
                end;
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        DocumentActionStatus := SetDocumentActionStatus();
        DocumentStatus := CheckDocumentStatus();
        CheckForDuplicateItemOnLine(Rec."Document No.");
    end;

    procedure GetNextPurchaseLineNo(DocumentNo: Code[20]): Integer
    var
        PurchaseLine: Record "Purchase Line";
        MaxLineNo: Integer;
    begin
        MaxLineNo := 0;
        if PurchaseLine.FindSet() then begin
            repeat
                if PurchaseLine."Document No." = DocumentNo then
                    if PurchaseLine."Line No." > MaxLineNo then
                        MaxLineNo := PurchaseLine."Line No.";
            until PurchaseLine.Next() = 0;
        end;
        exit(MaxLineNo + 10000);
    end;

    local procedure NextGnjlineNo(GenJTemplate: Code[20];
    GenJBatch: Code[20]): Integer
    var
        Genjline: Record "Gen. Journal Line";
    begin
        Genjline.SetRange("Journal Template Name", GenJTemplate);
        Genjline.SetRange("Journal Batch Name", GenJBatch);
        if Genjline.FindLast then exit(Genjline."Line No.");
    end;

    local procedure CheckDocumentStatus(): Boolean
    var
        CashPurchase: Record "Cash Purchase";
    begin
        if CashPurchase.Get(Rec."Document No.") then begin
            if CashPurchase.Status = CashPurchase.Status::Open then
                exit(true)
            else
                if (CashPurchase.Status in [CashPurchase.Status::"Pending Approval", CashPurchase.Status::Open, CashPurchase.Status::Released]) then
                    exit(false)
                else
                    if CashPurchase.Status = CashPurchase.Status::Released then exit(false);
        end;
    end;

    local procedure SetDocumentActionStatus(): Boolean
    var
        CashPurchase: Record "Cash Purchase";
    begin
        if CashPurchase.Get(Rec."Document No.") then begin
            if (CashPurchase.Status in [CashPurchase.Status::Released]) then
                exit(true)
            else
                exit(false);
        end;
    end;

    local procedure CheckDocumentforClosure(): Boolean
    var
        CashPurchaseLine: Record "Cash Purchase Line";
    begin
        CashPurchaseLine.Reset;
        CashPurchaseLine.SetRange("Document No.", Rec."Document No.");
        CashPurchaseLine.SetRange(Posted, false);
        if CashPurchaseLine.FindFirst then exit(true)
    end;

    local procedure DocumentClosure()
    var
        CashPurchase: Record "Cash Purchase";
    begin
        if CashPurchase.Get(Rec."Document No.") then begin
            CashPurchase.Validate(Posted, true);
            CashPurchase.Modify;
        end;
    end;

    local procedure CheckForDuplicateItemOnLine(ItemNo: Code[20])
    var
        MaterialRequitionLine: Record "Cash Purchase Line";
    begin
        MaterialRequitionLine.Reset;
        MaterialRequitionLine.SetRange("Document No.", Rec."Document No.");
        MaterialRequitionLine.SetRange("No.", ItemNo);
        if MaterialRequitionLine.FindSet then if MaterialRequitionLine.Count > 0 then Error('Selected item already exist');
    end;

    var
        DocumentActionStatus: Boolean;
        DocumentStatus: Boolean;
        CashPurchase: Record "Cash Purchase";
}

