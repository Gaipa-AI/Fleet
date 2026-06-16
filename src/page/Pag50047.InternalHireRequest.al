page 50047 "Internal Hire Request"
{
    Caption = 'Internal Hire Request';
    SourceTable = "Form Header";
    PageType = Card;
    RefreshOnActivate = true;
    PromotedActionCategories = 'New,Process,Report,New Document,Approve,Request Approval,Release,Home,Delegate';
    SourceTableView = WHERE("Document Type" = FILTER("Internal Hire"), "Client Category" = const(INTERNAL));

    layout
    {
        area(Content)
        {
            group(ClientDetails)
            {
                Caption = 'Client Details';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = PreviewMode;
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                    trigger OnAssistEdit();
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    Editable = PreviewMode;
                    ToolTip = 'Specifies the value of the Date field.', Comment = '%';
                }
                field("Client No."; Rec."Client No.")
                {
                    ApplicationArea = All;
                    Editable = PreviewMode;
                    ToolTip = 'Specifies the value of the Client No. field.', Comment = '%';
                }
                field("Client Name"; Rec."Client Name")
                {
                    ApplicationArea = All;
                    Editable = PreviewMode;
                    ToolTip = 'Specifies the value of the Client Name field.', Comment = '%';
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                    Editable = PreviewMode;
                    ToolTip = 'Specifies the value of the Address field.', Comment = '%';
                }
                // field("Address 2"; Rec."Address 2")
                // {
                //     ApplicationArea = All;
                //     Editable = PreviewMode;
                //     ToolTip = 'Specifies the value of the Address 2 field.', Comment = '%';
                // }
                field("Equipment Type"; Rec."Equipment Type")
                {
                    ApplicationArea = All;
                    Editable = PreviewMode;
                    ToolTip = 'Specifies the value of the Equipment Type field.', Comment = '%';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    Editable = PreviewMode;
                    ToolTip = 'Specifies the value of the Quantity field.', Comment = '%';
                }
                field("Job Location"; Rec."Job Location")
                {
                    ApplicationArea = All;
                    Editable = PreviewMode;
                    ToolTip = 'Specifies the value of the Job Location field.', Comment = '%';
                }
                field("Job Start Date"; Rec."Job Start Date")
                {
                    ApplicationArea = All;
                    Editable = PreviewMode;
                    ToolTip = 'Specifies the value of the Job Start Date field.', Comment = '%';

                }
                field("Job End Date"; Rec."Job End Date")
                {
                    ApplicationArea = All;
                   // Editable = PreviewMode;
                    ToolTip = 'Specifies the value of the Job End Date field.', Comment = '%';
                   
                }
                field("Hire days"; Rec."Hire Days")
                {
                    ApplicationArea = All;
                    Editable = PreviewMode;

                }
                field("Client Category"; Rec."Client Category")
                {
                    ApplicationArea = All;
                    Editable = PreviewMode;
                    ToolTip = 'Specifies the value of the Client Category field.', Comment = '%';
                }
                field("Contact Person Name"; Rec."Contact Person Name")
                {
                    ApplicationArea = All;
                    Editable = PreviewMode;
                    ToolTip = 'Specifies the value of the Contact Person Name field.', Comment = '%';
                }
                field("Contact Person Contact"; Rec."Contact Person Contact")
                {
                    ApplicationArea = All;
                    Editable = PreviewMode;
                    ToolTip = 'Specifies the value of the Contact Person Contact field.', Comment = '%';
                }
                // field("Contact Person Email"; Rec."Contact Person Email")
                // {
                //     ApplicationArea = All;
                //     Editable = PreviewMode;
                //     ToolTip = 'Specifies the value of the Contact Person Email field.', Comment = '%';
                // }
            }
            part(InternalHireLines; "Internal Hire Request Subform")
            {
                Caption = 'Lines';
                ApplicationArea = All;
                Editable = PreviewMode;
                SubPageLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
            }
            part(Employees; "Internal Hire Employee Type")
            {
                Caption = 'Employees';
                ApplicationArea = All;
                // Editable = PreviewMode;
                SubPageLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
            }
            group(TermsOfHire)
            {
                Caption = 'Terms Of Hire';
                field("Hourly Rate"; Rec."Hourly Rate")
                {
                    ApplicationArea = All;
                    Editable = PreviewMode;
                    ToolTip = 'Specifies the value of the Hourly Rate field.', Comment = '%';
                    
                }
                field(Daily; Rec.Daily)
                {
                    ApplicationArea = All;
                    Editable = PreviewMode;
                    ToolTip = 'Specifies the value of the Daily field.', Comment = '%';
                   
                }
                field(Monthly; Rec.Monthly)
                {
                    ApplicationArea = All;
                    Editable = PreviewMode;
                    ToolTip = 'Specifies the value of the Monthly field.', Comment = '%';
                   
                }
                field("Dry Hire"; Rec."Dry Hire")
                {
                    ApplicationArea = All;
                    Editable = PreviewMode;
                    ToolTip = 'Specifies the value of the Dry Hire field.', Comment = '%';
                    
                }
                field("Wet Hire"; Rec."Wet Hire")
                {
                    ApplicationArea = All;
                    Editable = PreviewMode;
                    ToolTip = 'Specifies the value of the Wet Hire field.', Comment = '%';
                  
                }
                field("Per Trip"; Rec."Per Trip")
                {
                    ApplicationArea = All;
                    Editable = PreviewMode;
                    ToolTip = 'Specifies the value of the Per Trip field.', Comment = '%';
                  
                }
                field(Other; Rec.Other)
                {
                    ApplicationArea = All;
                    Editable = PreviewMode;
                    ToolTip = 'Specifies the value of the Other field.', Comment = '%';
                    
                }
            }
            group(OfficialUse)
            {
                Caption = 'Official';
                field(Currency; Rec.Currency)
                {
                    ApplicationArea = All;
                    Editable = PreviewMode;
                    ToolTip = 'Specifies the value of the Currency field.', Comment = '%';
                }
                field("Hire Rate"; Rec."Hire Rate")
                {
                    ApplicationArea = All;
                    Editable = PreviewMode;
                    ToolTip = 'Specifies the value of the Hire Rate field.', Comment = '%';
                }
                field("Payment Terms"; Rec."Payment Terms")
                {
                    ApplicationArea = All;
                    Editable = PreviewMode;
                    ToolTip = 'Specifies the value of the Payment Terms field.', Comment = '%';
                }
                field(Authorized; Rec.Authorized)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Authorized field.', Comment = '%';
                }
                field("Authorized By"; Rec."Authorized By")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Authorized By field.', Comment = '%';
                }
                field("Authorized At"; Rec."Authorized At")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Authorized At field.', Comment = '%';
                }
                field("Set out"; Rec."Set out")
                {
                    ApplicationArea = All;
                    Caption = 'Journey Started';
                    ToolTip = 'Specifies the value of the Set out field.', Comment = '%';
                }
                field("Set out By"; Rec."Set out By")
                {
                    ApplicationArea = All;
                    Caption = 'Journey Started By.';
                    ToolTip = 'Specifies the value of the Set out By field.', Comment = '%';
                }
                field("Set Out Date"; Rec."Set Out Date")
                {
                    ApplicationArea = All;
                    Caption = 'Journey Start Date';
                    ToolTip = 'Specifies the value of the Set Out Date field.', Comment = '%';
                }
                field("Touch Down"; Rec."Touch Down")
                {
                    ApplicationArea = All;
                    Caption = 'Journey Ended';
                    ToolTip = 'Specifies the value of the Touch Down field.', Comment = '%';
                }
                field("Touch Down By"; Rec."Touch Down By")
                {
                    ApplicationArea = All;
                    Caption = 'Journey Ended By';
                    ToolTip = 'Specifies the value of the Touch Down By field.', Comment = '%';
                }
                field("Touch Down Date"; Rec."Touch Down Date")
                {
                    ApplicationArea = All;
                    Caption = 'Journey Ended Date';
                    ToolTip = 'Specifies the value of the Touch Down Date field.', Comment = '%';
                }
                field("Prepared by"; Rec."Prepared by")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prepared by field.', Comment = '%';
                    Editable = false;
                }
            }

            group(Invoicing)
            {
                field("Line To Invoice Type"; Rec."Line To Invoice Type")
                {
                    ApplicationArea = All;
                    Editable = ConvertedValue;
                    ToolTip = 'Specifies the value of the Line To Invoice Type field.', Comment = '%';
                }
                field("Line To Invoice No."; Rec."Line To Invoice No.")
                {
                    ApplicationArea = All;
                    Editable = ConvertedValue;
                    ToolTip = 'Specifies the value of the Line To Invoice No. field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                    Editable = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    Editable = ConvertedValue;
                    ToolTip = 'Specifies the value of the Posting Date field.', Comment = '%';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                    Editable = ConvertedValue;
                    ToolTip = 'Specifies the value of the Unit of Measure Code field.', Comment = '%';
                }
                field(Converted; Rec.Converted)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Converted field.', Comment = '%';
                }
                field("Sales Invoice/Order No."; Rec."Sales Invoice/Order No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sales Invoice/Order No. field.', Comment = '%';
                    Editable = false;
                }
                field("Terms of Hire"; Rec.TermsofHire)
                {
                    ApplicationArea = All;
                    Tooltip = 'Selected terms of hire';
                    Editable = false;
                    

                }
                field("Estimated Cost"; Rec.EstimatedHireCost)
                {
                    ApplicationArea = All;
                    Tooltip = 'Cost of hire';
                   
                }
                
            }
        }

        area(Factboxes)
        {
            part("Attached Documents"; "Doc. Attachment List Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(Database::"Form Header"), "No." = FIELD("No.");
            }
            systempart(Links; Links)
            {
                ApplicationArea = RecordLinks;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = Notes;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Print)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Print';
                Image = Print;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;

                trigger OnAction();
                var
                    RequisitionHeader: Record "Form Header";
                    RptPurchaseRequisition: Report "Hire Request";
                begin
                    RequisitionHeader.SETRANGE("Document Type", RequisitionHeader."Document Type"::"Internal Hire");
                    RequisitionHeader.SETRANGE("No.", Rec."No.");
                    RptPurchaseRequisition.SETTABLEVIEW(RequisitionHeader);
                    RptPurchaseRequisition.RUNMODAL;
                end;
            }
            action(AuthorizeRequest)
            {
                ApplicationArea = All;
                Caption = 'Authorize Hire Request';
                Image = AuthorizeCreditCard;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to Authorize this Hire Request?', true) then
                        AuthorizeHireRequest();
                      
                    CurrPage.Update();
                end;
            }
            action(CreateSalesInvoice)
            {
                ApplicationArea = All;
                Caption = 'Create Sales Invoice';
                Image = CreateDocument;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    DocumentType: Enum "Sales Document Type";
                begin

                    Rec.TestField(Converted, false);
                    Rec.TestField(Authorized, true);
                    if Confirm('Are you sure you want to create a sales Invoice', true) then
                        Rec.CreateSalesInvoice(DocumentType::Invoice);
                end;
            }
            action(CreateSalesOrder)
            {
                ApplicationArea = All;
                Caption = 'Create Sales Order';
                Image = CreateDocument;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    DocumentType: Enum "Sales Document Type";
                begin
                   
                    
                    Rec.TestField(Converted, false);
                    Rec.TestField(Authorized, true);
                    if Confirm('Are you sure you want to create a sales Order', true) then
                        Rec.CreateSalesInvoice(DocumentType::Order);
                end;
            }

            action(StartJourney)
            {
                ApplicationArea = All;
                Caption = 'Start Journey';
                Image = CreateDocument;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    Rec.TestField(Authorized, true);
                    CheckForEquipmentLines();
                    if Confirm('Are you sure you want to start this Journey?', true) then
                        Rec.SetOut();
                    CurrPage.Update();
                end;
            }
            action(EndJourney)
            {
                ApplicationArea = All;
                Caption = 'End Journey';
                Image = CreateDocument;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    Rec.TestField(Authorized, true);
                    CheckForEquipmentLines();
                    if Confirm('Are you sure you want to End this Journey?', true) then
                        Rec.touchDown();
                    CurrPage.Update();
                end;
            }
            action(HireRate)
            {
                ApplicationArea = All;
                Caption = 'Hire Terms';
                Image = Refresh;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                   GetTermsOfHireText();
                end;
            }
            action(CalculateCost)
            {
                ApplicationArea = All;
                Caption = 'Calculate Cost';
                Image = Check;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    Rec."Line To Invoice Type" := Rec."Line To Invoice Type"::"G/L Account";
                    Rec."Line To Invoice No." := '15100';
                    Rec."Unit of Measure Code" := 'EACH';
                    Rec."Posting Date" := Today();
                    GetTermsOfHireText();
                   Rec.EstimatedHireCost := CalculateEstimatedCost();
                   Rec.Modify();
                end;
            }

        }

        area(Navigation)
        {
            group(Request)
            {
                action("Comments")
                {
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Purch. Comment Sheet";
                    RunPageLink = "Document Type" = filter("Internal Hire"),
                                  "No." = FIELD("No."),
                                  "Document Line No." = CONST(0);
                }
                action(salesInvoices)
                {
                    ApplicationArea = All;
                    Caption = 'Sales Invoices';
                    Image = List;
                    RunObject = page "Sales Invoice List";
                    RunPageLink = "Equipment Hire No." = field("No.");
                }
                action(salesOrders)
                {
                    ApplicationArea = All;
                    Caption = 'Sales Orders';
                    Image = List;
                    RunObject = page "Sales Order List";
                    RunPageLink = "Equipment Hire No." = field("No.");
                }
                action(PostedSalesInvoices)
                {
                    ApplicationArea = All;
                    Caption = 'Posted Sales Invoices';
                    Image = List;
                    RunObject = page "Posted Sales Invoices";
                    RunPageLink = "Equipment Hire No." = field("No.");
                }
                action(PostedSalesCreditMemo)
                {
                    ApplicationArea = All;
                    Caption = 'Posted Sales CreditMemo';
                    Image = List;
                    RunObject = page "Posted Sales Credit Memos";
                    RunPageLink = "Equipment Hire No." = field("No.");
                }
                action(DocAttach)
                {
                    ApplicationArea = All;
                    Caption = 'Attachments';
                    Image = Attach;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                    trigger OnAction()
                    var
                        DocumentAttachmentDetails: Page "Document Attachment Details";
                        RecRef: RecordRef;
                    begin
                        RecRef.GetTable(Rec);
                        DocumentAttachmentDetails.OpenForRecRef(RecRef);
                        DocumentAttachmentDetails.RunModal;
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        Rec."Client Category" := Rec."Client Category"::INTERNAL;
        PreviewMode := true;
        ConvertedValue := true;
        Rec."Document Type" := Rec."Document Type"::"Internal Hire";
        Rec."Prepared by" := UserId;

        if Rec.Authorized then
            PreviewMode := false;
        if Rec.Converted then
            ConvertedValue := false;
    end;

    var

        PreviewMode: Boolean;
        ConvertedValue: Boolean;

    procedure AuthorizeHireRequest()
    var
        UserSetup: Record "User Setup";
        FormHeader: Record "Form Header";
    begin
        Rec.TestField("No.");
        rec.TestField(Date);
        rec.TestField("Client Name");
        Rec.TestField("Job Location");
        Rec.TestField("Job End Date");
        Rec.TestField("Job Start Date");
        Rec.TestField("Equipment Type");
        Rec.TestField(Quantity);
        Rec.TestField("Hire Rate");
        Rec.TestField("Payment Terms");
        Rec.TestField(Converted, false);
        CheckForEquipmentLines();
        UserSetup.Reset();
        UserSetup.SetRange("User ID", UserId);
        UserSetup.SetRange("Can Authorize Hire Request", true);
        if UserSetup.FindFirst() then begin
            FormHeader.Reset();
            FormHeader.SetRange("No.", Rec."No.");
            FormHeader.SetRange("Document Type", FormHeader."Document Type"::"Internal Hire");
            if FormHeader.FindFirst() then begin
                FormHeader.Authorized := True;
                FormHeader."Authorized At" := Today();
                FormHeader."Authorized By" := UserId;
                FormHeader.Status := FormHeader.Status::Released;
                FormHeader.Modify();
            end;
        end else
            Error('You are not setup please, Contact your Administrator.');
    end;

    procedure CheckForEquipmentLines()
    var
        FormLines: Record "Form Line";
    begin
        FormLines.Reset();
        FormLines.SetRange("Document Type", Rec."Document Type");
        FormLines.SetRange("Document No.", Rec."No.");
        if not FormLines.FindFirst() then
            Error('Please select the item(s) to be hired out.');
    end;

    local procedure GetTermsOfHireText(): Text[100]
    
    begin
        if Rec."Hourly Rate" = not false then
            Rec.TermsOfHire := 'Hourly'
        else
        if Rec.Monthly = not false then
            Rec.TermsOfHire := 'Monthly'
        else
        if Rec."Per Trip" = not false then
            Rec.TermsOfHire := 'Per Trip'
        else
        if Rec."Dry Hire" = not false then
            Rec.TermsOfHire := 'Dry Hire'
        else
        if Rec."Wet Hire" = not false then
            Rec.TermsOfHire := 'Wet Hire'
        else
        if Rec."Daily" = not false then
            Rec.TermsOfHire := 'Daily'
        else
        if Rec.Other <> '' then
            Rec.TermsOfHire := 'Other: ' + Rec.Other
        else
            Rec.TermsOfHire := '';

        Rec.Modify();

    end;

    local procedure CalculateEstimatedCost(): Decimal
    begin
        if Rec.Quantity = 0 then
            exit(0);

        exit(Rec.Quantity * Rec."Hire Rate" * GetHireDurationFactor());
    end;

local procedure GetHireDurationFactor(): Decimal
begin
    if Rec."Per Trip" then
        exit(Rec."Hire Days" * 2);

    if Rec."Hourly Rate" then
        exit(Rec."Hire Days" * 24);

    // if Rec.Weekly then
    //     exit(Rec."Hire Days" / 7);

    if Rec.Monthly then
        exit(Rec."Hire Days" / 30);

    // Daily / Dry Hire / Wet Hire are charged per day
    if Rec."Daily" or Rec."Dry Hire" or Rec."Wet Hire" then
        exit(Rec."Hire Days");

    // fallback
    exit(Rec."Hire Days");
 end;

}