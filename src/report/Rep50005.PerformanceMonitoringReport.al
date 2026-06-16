report 50005 "Performance Monitoring Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    //DefaultRenderingLayout = LayoutName;
    DefaultLayout = RDLC;
    RDLCLayout = 'PerformanceMonitoring.rdl';
    Caption = 'Performance Monitoring Form';

    dataset
    {
        dataitem("Performance Header"; "Performance Header")
        {
            
            RequestFilterFields = "Document Type", "No.", "Driver No.";
            column(No_; "No.") { }
            column(Start_Date; "Start Date") { }
            column(End_Date; "End Date") { }
            column(CompanyInfo_Picture; CompanyInfo.Picture) { }
            column(CompanyInfo_Name; CompanyInfo.Name) { }
            dataitem("Performance Line"; "Performance Line")
            {
                DataItemLinkReference = "Performance Header";
                DataItemLink = "Document Type" = FIELD("Document Type"),
                               "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");

                column(EmployeeNo_PerformanceLine; "Employee No.")
                {
                }
                column(EmployeeName_PerformanceLine; "Employee Name")
                {
                }
                column(Designation_PerformanceLine; Designation)
                {
                }
                column(JobExpectations_PerformanceLine; "Job Expectations")
                {
                }
                column(Date_PerformanceLine; Date)
                {
                }
                column(DaysWorked_PerformanceLine; "Days Worked")
                {
                }
                column(JobsExecuted_PerformanceLine; "Jobs Executed")
                {
                }
                column(KMCovered_PerformanceLine; "KM Covered")
                {
                }
                column(HoursWorked_PerformanceLine; "Hours Worked")
                {
                }
                column(IncidentsCaused_PerformanceLine; "Incidents Caused")
                {
                }
                column(NoOfClientComplaints_PerformanceLine; "No. Of Client Complaints")
                {
                }
               
            }

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                
            end;
        }
    }


    // rendering
    // {
    //     layout(LayoutName)
    //     {
    //         Type = RDLC;
    //         LayoutFile = 'PerformanceMonitoring.rdl';
    //     }
    // }
    // requestpage
    // {
    //     layout
    //     {
    //         area(Content)
    //         {
    //             group(Filters)
    //             {
    //                 field(Document; "")
    //                 {
    //                     ApplicationArea = All;
    //                     Caption = 'Location Code';
    //                     TableRelation = Location;
    //                 }

    //                 field(AsAtDate; AsAtDate)
    //                 {
    //                     ApplicationArea = All;
    //                     Caption = 'Stock As At Date';
    //                 }
    //             }
    //         }
    //     }
    // }

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
}